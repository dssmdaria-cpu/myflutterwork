import 'package:supabase_flutter/supabase_flutter.dart';

// Конфигурация Supabase
class SupabaseConfig {
  
  static const String supabaseUrl = 'https://rezfjbdpoyhxusmmodgx.supabase.co'; 
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJlemZqYmRwb3loeHVzbW1vZGd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI3NjExMTcsImV4cCI6MjA3ODMzNzExN30.WiPLCUSqyV9GAg2QK-V0Y7CIgVoAYYXf0KHJbAQE9PE'; 
  
  // Инициализация Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
  
  // Получить клиент Supabase
  static SupabaseClient get client => Supabase.instance.client;
  
  // Получить текущего пользователя
  static User? get currentUser => client.auth.currentUser;
  
  // Проверка авторизации
  static bool get isAuthenticated => currentUser != null;
}

// Сервис авторизации
class AuthService {
  final SupabaseClient _supabase = SupabaseConfig.client;
  
  // Регистрация
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: name != null ? {'name': name} : null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Вход
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Выход
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
  
  // Сброс пароля
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }
  
  // Получить текущего пользователя
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }
  
  // Слушать изменения статуса авторизации
  Stream<AuthState> get authStateChanges {
    return _supabase.auth.onAuthStateChange;
  }
}
