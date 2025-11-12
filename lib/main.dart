import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'supabase_config.dart';
import 'services.dart';
import 'models.dart';

// Точка входа в приложение
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация Supabase
  await SupabaseConfig.initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartService()),
        ChangeNotifierProvider(create: (_) => FavoritesService()),
      ],
      child: const UrbanStyleApp(),
    ),
  );
}

// Главный виджет приложения
class UrbanStyleApp extends StatelessWidget {
  const UrbanStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UrbanStyle',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.grey[800]!,
          surface: const Color(0xFF1E1E1E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
        cardColor: const Color(0xFF1E1E1E),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Главная страница приложения
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Показывать ли меню авторизации
  bool _showAuthMenu = false;
  bool _showProfileMenu = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (SupabaseConfig.isAuthenticated) {
      await context.read<CartService>().loadFromSupabase();
      await context.read<FavoritesService>().loadFromSupabase();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold - основная структура страницы
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      
      // Drawer - выдвижное боковое меню (бургер-меню)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Шапка меню - минималистичный дизайн
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[800]!,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[850],
                    child: Icon(
                      Icons.person_outline,
                      size: 35,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'UrbanStyle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Коллекция 2025',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            
            // Пункты меню - минималистичный стиль
            ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.grey[400], size: 24),
              title: Text(
                'Главная',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Закрыть меню
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined, color: Colors.grey[400], size: 24),
              title: Text(
                'Каталог',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer_outlined, color: Colors.grey[400], size: 24),
              title: Text(
                'Акции',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline, color: Colors.grey[400], size: 24),
              title: Text(
                'Избранное',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_outlined, color: Colors.grey[400], size: 24),
              title: Text(
                'Корзина',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(color: Colors.grey[800], height: 1),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.grey[400], size: 24),
              title: Text(
                'О нас',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support_outlined, color: Colors.grey[400], size: 24),
              title: Text(
                'Контакты',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined, color: Colors.grey[400], size: 24),
              title: Text(
                'Настройки',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      
      // Основное содержимое страницы
      body: Builder(
        builder: (context) => Stack(
          children: [
            SafeArea(
              // Column - вертикальное расположение виджетов
              child: Column(
                children: [
                  // Шапка с логотипом и аватаром
                  _buildHeader(context),
                  
                  // Expanded - занимает всё доступное пространство
                  Expanded(
              // SingleChildScrollView - прокручиваемый контейнер (вертикальный по умолчанию)
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Главное изображение
                    _buildMainImage(),
                    
                    const SizedBox(height: 20),
                    
                    // Горизонтальная галерея товаров
                    _buildClothesGallery(),
                    
                    const SizedBox(height: 30),
                    
                    // Сетка с фактами о бренде
                    _buildFactsGrid(),
                    
                    const SizedBox(height: 40),
                    
                    // Завершение страницы с призывом к действию
                    _buildCallToAction(context),
                    
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
            
            // Меню авторизации поверх контента (позиционированное)
            if (_showAuthMenu)
              Positioned(
                top: 80,
                right: 16,
                child: _buildAuthMenu(),
              ),
            
            // Меню профиля поверх контента
            if (_showProfileMenu)
              Positioned(
                top: 80,
                right: 16,
                child: _buildProfileMenu(),
              ),
          ],
        ),
      ),
    );
  }

  // Шапка страницы с логотипом и аватаром
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // Row - горизонтальное расположение виджетов
      child: Row(
        // mainAxisAlignment - выравнивание по главной оси (spaceBetween - требование)
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Кнопка бургер-меню
          IconButton(
            icon: Icon(Icons.menu, size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Открыть меню
            },
          ),
          
          // Название магазина посередине
          Text(
            'UrbanStyle',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Белый цвет для темной темы
            ),
          ),
          
          // CircleAvatar с radius и NetworkImage (требования)
          // При нажатии открывается меню авторизации или профиля
          GestureDetector(
            onTap: () {
              setState(() {
                if (SupabaseConfig.isAuthenticated) {
                  _showProfileMenu = !_showProfileMenu;
                  _showAuthMenu = false;
                } else {
                  _showAuthMenu = !_showAuthMenu;
                  _showProfileMenu = false;
                }
              });
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: SupabaseConfig.isAuthenticated ? Colors.white : Colors.grey[300],
              child: SupabaseConfig.isAuthenticated
                  ? Text(
                      _getUserInitials(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey[700],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Получить инициалы пользователя
  String _getUserInitials() {
    final user = SupabaseConfig.currentUser;
    if (user == null) return '?';
    
    final name = user.userMetadata?['name'] as String?;
    if (name != null && name.isNotEmpty) {
      final parts = name.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return name[0].toUpperCase();
    }
    
    final email = user.email ?? '';
    return email.isNotEmpty ? email[0].toUpperCase() : '?';
  }

  // Меню авторизации
  Widget _buildAuthMenu() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(128),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Добро пожаловать!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.grey[400]),
                onPressed: () {
                  setState(() {
                    _showAuthMenu = false;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Кнопка "Войти"
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showAuthMenu = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Войти',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          
          const SizedBox(height: 10),
          
          // Кнопка "Зарегистрироваться"
          OutlinedButton(
            onPressed: () {
              setState(() {
                _showAuthMenu = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: Colors.grey[600]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Зарегистрироваться',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Меню профиля пользователя
  Widget _buildProfileMenu() {
    final user = SupabaseConfig.currentUser;
    final userName = user?.userMetadata?['name'] as String? ?? 'Пользователь';
    final userEmail = user?.email ?? '';
    final cartService = context.watch<CartService>();

    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(128),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.grey[400]),
                onPressed: () {
                  setState(() {
                    _showProfileMenu = false;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Корзина
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            title: const Text('Корзина', style: TextStyle(color: Colors.white)),
            trailing: cartService.itemCount > 0
                ? Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartService.itemCount}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                : null,
            onTap: () {
              setState(() {
                _showProfileMenu = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
          
          Divider(color: Colors.grey[800]),
          
          // Избранное
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.favorite_outline, color: Colors.white),
            title: const Text('Избранное', style: TextStyle(color: Colors.white)),
            onTap: () {
              setState(() {
                _showProfileMenu = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
          
          Divider(color: Colors.grey[800]),
          
          // Выход
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.logout, color: Colors.red[400]),
            title: Text('Выйти', style: TextStyle(color: Colors.red[400])),
            onTap: () async {
              await AuthService().signOut();
              setState(() {
                _showProfileMenu = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Вы вышли из аккаунта')),
              );
            },
          ),
        ],
      ),
    );
  }

  // Главное изображение коллекции
  Widget _buildMainImage() {
    // Container с width, height, decoration (требования)
    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      // BoxDecoration с color (требование)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=800&h=600&fit=crop', // Стильное фото моды
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha(77),
              Colors.black.withAlpha(128),
            ],
          ),
        ),
        child: Center(
          // Column для вертикального расположения
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text с TextStyle (требование)
              const Text(
                'UrbanStyle',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Collection 2025',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Новая весенняя коллекция',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Горизонтальная галерея товаров
  Widget _buildClothesGallery() {
    // Список товаров
    final items = [
      {'name': 'Джинсы', 'price': '5 990 ₽', 'icon': Icons.checkroom},
      {'name': 'Куртка', 'price': '12 990 ₽', 'icon': Icons.sports_martial_arts},
      {'name': 'Футболка', 'price': '2 490 ₽', 'icon': Icons.dry_cleaning},
      {'name': 'Кроссовки', 'price': '8 990 ₽', 'icon': Icons.soap},
      {'name': 'Худи', 'price': '6 490 ₽', 'icon': Icons.checkroom_outlined},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Популярные товары',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Container с height
        Container(
          height: 200,
          // SingleChildScrollView с direction: Axis.horizontal (горизонтальная прокрутка - требование)
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items.map((item) {
                // Container с width, decoration: BoxDecoration (требования)
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[800]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['price'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Сетка с фактами о бренде (4 квадратика по горизонтали)
  Widget _buildFactsGrid() {
    final facts = [
      {'title': '2015', 'desc': 'Год основания'},
      {'title': '50+', 'desc': 'Стран доставки'},
      {'title': '100%', 'desc': 'Эко материалы'},
      {'title': '24/7', 'desc': 'Поддержка'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'О бренде UrbanStyle',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          // GridView для отображения фактов в сетке
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 колонки
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
            itemCount: facts.length,
            itemBuilder: (context, index) {
              // Container с decoration: BoxDecoration (требование)
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        facts[index]['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        facts[index]['desc']!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Завершение страницы с призывом к действию и кнопкой в каталог
  Widget _buildCallToAction(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[700]!, width: 2),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          const Text(
            'Готовы обновить свой стиль?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Откройте для себя нашу коллекцию стильной одежды',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CatalogPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Перейти в каталог',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Страница "Каталог"
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  // Список товаров
  static final List<Product> products = [
    Product(
      id: '1',
      name: 'Черная куртка',
      description: 'Стильная черная куртка из эко-кожи',
      price: 8999.00,
      imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400&h=600&fit=crop',
      category: 'Верхняя одежда',
    ),
    Product(
      id: '2',
      name: 'Синие джинсы',
      description: 'Классические прямые джинсы',
      price: 4999.00,
      imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&h=600&fit=crop',
      category: 'Джинсы',
    ),
    Product(
      id: '3',
      name: 'Белая футболка',
      description: 'Базовая футболка из хлопка',
      price: 1299.00,
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=600&fit=crop',
      category: 'Футболки',
    ),
    Product(
      id: '4',
      name: 'Кроссовки',
      description: 'Удобные белые кроссовки',
      price: 6999.00,
      imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&h=600&fit=crop',
      category: 'Обувь',
    ),
    Product(
      id: '5',
      name: 'Худи серое',
      description: 'Теплое худи оверсайз',
      price: 3499.00,
      imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400&h=600&fit=crop',
      category: 'Худи',
    ),
    Product(
      id: '6',
      name: 'Черные шорты',
      description: 'Спортивные шорты',
      price: 2299.00,
      imageUrl: 'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?w=400&h=600&fit=crop',
      category: 'Шорты',
    ),
    Product(
      id: '7',
      name: 'Рубашка',
      description: 'Белая классическая рубашка',
      price: 3999.00,
      imageUrl: 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=400&h=600&fit=crop',
      category: 'Рубашки',
    ),
    Product(
      id: '8',
      name: 'Свитер',
      description: 'Вязаный свитер',
      price: 4499.00,
      imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=400&h=600&fit=crop',
      category: 'Свитера',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Каталог'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}

// Карточка товара
class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartService = context.watch<CartService>();
    final favoritesService = context.watch<FavoritesService>();
    final isInCart = cartService.isInCart(product.id);
    final isFavorite = favoritesService.isFavorite(product.id);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение товара
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[800],
                      child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 50),
                    );
                  },
                ),
              ),
              // Кнопка избранного
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    favoritesService.toggleFavorite(product.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red[400] : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Информация о товаре
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)} ₽',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Кнопка добавления в корзину
                      GestureDetector(
                        onTap: () {
                          if (isInCart) {
                            cartService.removeFromCart(product.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} удален из корзины'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          } else {
                            cartService.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} добавлен в корзину'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isInCart ? Colors.green[700] : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isInCart ? Icons.check : Icons.add_shopping_cart,
                            color: isInCart ? Colors.white : Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Страница "Акции"
class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Акции'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_offer_outlined, size: 100, color: Colors.grey[700]),
            const SizedBox(height: 20),
            const Text(
              'Акции и скидки',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Специальные предложения для вас',
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

// Страница "Избранное"
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesService = context.watch<FavoritesService>();
    
    // Получаем только избранные товары из каталога
    final favoriteProducts = CatalogPage.products
        .where((product) => favoritesService.isFavorite(product.id))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Избранное'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_outline, size: 100, color: Colors.grey[700]),
                  const SizedBox(height: 20),
                  const Text(
                    'Избранные товары',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Вы еще не добавили товары в избранное',
                    style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CatalogPage()),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Перейти в каталог'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  return _ProductCard(product: favoriteProducts[index]);
                },
              ),
            ),
    );
  }
}

// Страница "Корзина"
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = context.watch<CartService>();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Корзина'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        actions: [
          if (cartService.itemCount > 0)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1E1E1E),
                    title: const Text('Очистить корзину?', style: TextStyle(color: Colors.white)),
                    content: const Text('Все товары будут удалены из корзины', style: TextStyle(color: Colors.grey)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () {
                          cartService.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Очистить', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: cartService.itemCount == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[700]),
                  const SizedBox(height: 20),
                  const Text(
                    'Корзина покупок',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ваша корзина пуста',
                    style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CatalogPage()),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Перейти в каталог'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartService.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartService.items[index];
                      return _CartItemCard(cartItem: cartItem);
                    },
                  ),
                ),
                // Итоговая сумма
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    border: Border(top: BorderSide(color: Colors.grey[800]!)),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Итого:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Text(
                              '${cartService.totalPrice.toStringAsFixed(0)} ₽',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Оформление заказа (в разработке)')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Оформить заказ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// Карточка товара в корзине
class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const _CartItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartService = context.read<CartService>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение товара
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              cartItem.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[800],
                  child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Информация о товаре
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  cartItem.product.category,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const SizedBox(height: 8),
                Text(
                  '${cartItem.product.price.toStringAsFixed(0)} ₽',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          // Управление количеством
          Column(
            children: [
              Row(
                children: [
                  // Кнопка уменьшения
                  GestureDetector(
                    onTap: () {
                      if (cartItem.quantity > 1) {
                        cartService.updateQuantity(cartItem.product.id, cartItem.quantity - 1);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(Icons.remove, size: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Количество
                  Text(
                    '${cartItem.quantity}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  // Кнопка увеличения
                  GestureDetector(
                    onTap: () {
                      cartService.updateQuantity(cartItem.product.id, cartItem.quantity + 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(Icons.add, size: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Кнопка удаления
              GestureDetector(
                onTap: () {
                  cartService.removeFromCart(cartItem.product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${cartItem.product.name} удален из корзины'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(Icons.delete_outline, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Страница "О нас"
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('О нас'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'О бренде UrbanStyle',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'UrbanStyle - это современный бренд одежды, основанный в 2015 году. Мы создаём стильную и качественную одежду для тех, кто ценит комфорт и индивидуальность.',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[400]),
            ),
            const SizedBox(height: 20),
            const Text(
              'Наши преимущества:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              '• 100% эко материалы\n• Доставка в 50+ стран\n• Гарантия качества 10 лет\n• Бесплатная доставка от 5000₽',
              style: TextStyle(fontSize: 16, height: 1.8, color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }
}

// Страница "Контакты"
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Контакты'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Свяжитесь с нами',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.grey[400], size: 30),
            title: const Text('Телефон', style: TextStyle(color: Colors.white)),
            subtitle: Text('+7 (800) 555-35-35', style: TextStyle(color: Colors.grey[500])),
          ),
          Divider(color: Colors.grey[800]),
          ListTile(
            leading: Icon(Icons.email, color: Colors.grey[400], size: 30),
            title: const Text('Email', style: TextStyle(color: Colors.white)),
            subtitle: Text('info@urbanstyle.com', style: TextStyle(color: Colors.grey[500])),
          ),
          Divider(color: Colors.grey[800]),
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.grey[400], size: 30),
            title: const Text('Адрес', style: TextStyle(color: Colors.white)),
            subtitle: Text('Москва, ул. Тверская, д. 1', style: TextStyle(color: Colors.grey[500])),
          ),
          Divider(color: Colors.grey[800]),
          ListTile(
            leading: Icon(Icons.access_time, color: Colors.grey[400], size: 30),
            title: const Text('Часы работы', style: TextStyle(color: Colors.white)),
            subtitle: Text('Пн-Вс: 10:00 - 22:00', style: TextStyle(color: Colors.grey[500])),
          ),
        ],
      ),
    );
  }
}

// Страница "Настройки"
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Настройки'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language, color: Colors.grey[400]),
            title: const Text('Язык', style: TextStyle(color: Colors.white)),
            subtitle: Text('Русский', style: TextStyle(color: Colors.grey[500])),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          ),
          Divider(color: Colors.grey[800]),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.grey[400]),
            title: const Text('Уведомления', style: TextStyle(color: Colors.white)),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.white,
            ),
          ),
          Divider(color: Colors.grey[800]),
          ListTile(
            leading: Icon(Icons.dark_mode, color: Colors.grey[400]),
            title: const Text('Тёмная тема', style: TextStyle(color: Colors.white)),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.white,
            ),
          ),
          Divider(color: Colors.grey[800]),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.grey[400]),
            title: const Text('Конфиденциальность', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          ),
          Divider(color: Colors.grey[800]),
          ListTile(
            leading: Icon(Icons.help, color: Colors.grey[400]),
            title: const Text('Помощь', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// Страница входа
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Успешный вход!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка входа: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Вход'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            
            // Иконка
            Icon(
              Icons.lock_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            
            const SizedBox(height: 20),
            
            const Text(
              'Войти в аккаунт',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Поле email
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            
            const SizedBox(height: 20),
            
            // Поле пароля
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Забыли пароль
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  print('Забыли пароль?');
                },
                child: Text(
                  'Забыли пароль?',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Кнопка входа
            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Text(
                      'Войти',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            
            const SizedBox(height: 20),
            
            // Переход на регистрацию
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Нет аккаунта? ',
                  style: TextStyle(color: Colors.grey[500]),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Страница регистрации
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пароли не совпадают')),
      );
      return;
    }

    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пароль должен быть минимум 6 символов')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Регистрация успешна! Проверьте email для подтверждения.'),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка регистрации: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Регистрация'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            
            // Иконка
            Icon(
              Icons.person_add_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            
            const SizedBox(height: 20),
            
            const Text(
              'Создать аккаунт',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Поле имени
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Имя',
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Поле email
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            
            const SizedBox(height: 20),
            
            // Поле пароля
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Поле подтверждения пароля
            TextField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Подтвердите пароль',
                labelStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Кнопка регистрации
            ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            
            const SizedBox(height: 20),
            
            // Переход на вход
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Уже есть аккаунт? ',
                  style: TextStyle(color: Colors.grey[500]),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Войти',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
