import 'package:flutter/material.dart';
import 'catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ClothingStore(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ClothingStore extends StatefulWidget {
  const ClothingStore({super.key});

  @override
  _ClothingStoreState createState() => _ClothingStoreState();
}

class _ClothingStoreState extends State<ClothingStore> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Шапка с названием и меню
            Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  // Название магазина слева
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Fashion Store',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  // Пустое пространство между названием и меню
                  const Expanded(
                    child: SizedBox(),
                  ),
                  
                  // Кнопка меню справа
                  Container(
                    padding: EdgeInsets.all(16),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _showMenu = !_showMenu;
                        });
                      },
                      mini: true,
                      child: Icon(Icons.menu),
                    ),
                  ),
                ],
              ),
            ),
            
            // Выпадающее меню
            if (_showMenu)
              Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _showMenu = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text('Главная'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _showMenu = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CatalogPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text('Каталог'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text('О нас'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text('Контакты'),
                    ),
                  ],
                ),
              ),
            
            // Основной контент
            Container(
              height: 300,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Заголовок
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Новая коллекция',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Описание
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Стильная одежда для каждого дня. Качественные материалы и современный дизайн.',
                textAlign: TextAlign.center,
              ),
            ),
            
            // Круглые аватары категорий
            Container(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Кнопка действия
            Container(
              margin: EdgeInsets.all(16),
              child: FloatingActionButton(
                onPressed: () {},
                child: Text('Купить'),
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}