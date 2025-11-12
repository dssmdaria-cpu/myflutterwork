import 'package:flutter/foundation.dart';
import 'models.dart';
import 'supabase_config.dart';

// Сервис корзины
class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => List.unmodifiable(_items);
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
  
  // Добавить товар в корзину
  void addToCart(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    
    notifyListeners();
    _saveToSupabase();
  }
  
  // Удалить товар из корзины
  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
    _saveToSupabase();
  }
  
  // Изменить количество
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }
    
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
      _saveToSupabase();
    }
  }
  
  // Очистить корзину
  void clear() {
    _items.clear();
    notifyListeners();
    _saveToSupabase();
  }
  
  // Проверить, есть ли товар в корзине
  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }
  
  // Получить количество товара
  int getQuantity(String productId) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(id: '', name: '', description: '', price: 0, imageUrl: '', category: ''), quantity: 0),
    );
    return item.quantity;
  }
  
  // Сохранить корзину в Supabase (для авторизованных пользователей)
  Future<void> _saveToSupabase() async {
    final user = SupabaseConfig.currentUser;
    if (user == null) return;
    
    try {
      final cartData = _items.map((item) => item.toJson()).toList();
      await SupabaseConfig.client
          .from('user_carts')
          .upsert({
            'user_id': user.id,
            'cart_data': cartData,
            'updated_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      print('Ошибка сохранения корзины: $e');
    }
  }
  
  // Загрузить корзину из Supabase
  Future<void> loadFromSupabase() async {
    final user = SupabaseConfig.currentUser;
    if (user == null) return;
    
    try {
      final response = await SupabaseConfig.client
          .from('user_carts')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();
      
      if (response != null && response['cart_data'] != null) {
        _items.clear();
        final List<dynamic> cartData = response['cart_data'];
        for (var itemJson in cartData) {
          _items.add(CartItem.fromJson(itemJson));
        }
        notifyListeners();
      }
    } catch (e) {
      print('Ошибка загрузки корзины: $e');
    }
  }
}

// Сервис избранного
class FavoritesService extends ChangeNotifier {
  final Set<String> _favoriteIds = {};
  
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);
  
  bool isFavorite(String productId) => _favoriteIds.contains(productId);
  
  void toggleFavorite(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
    _saveToSupabase();
  }
  
  Future<void> _saveToSupabase() async {
    final user = SupabaseConfig.currentUser;
    if (user == null) return;
    
    try {
      await SupabaseConfig.client
          .from('user_favorites')
          .upsert({
            'user_id': user.id,
            'product_ids': _favoriteIds.toList(),
            'updated_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      print('Ошибка сохранения избранного: $e');
    }
  }
  
  Future<void> loadFromSupabase() async {
    final user = SupabaseConfig.currentUser;
    if (user == null) return;
    
    try {
      final response = await SupabaseConfig.client
          .from('user_favorites')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();
      
      if (response != null && response['product_ids'] != null) {
        _favoriteIds.clear();
        final List<dynamic> ids = response['product_ids'];
        _favoriteIds.addAll(ids.cast<String>());
        notifyListeners();
      }
    } catch (e) {
      print('Ошибка загрузки избранного: $e');
    }
  }
}
