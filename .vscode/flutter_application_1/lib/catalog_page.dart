import 'package:flutter/material.dart';

// Страница каталога
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
          children: [
            // Толстовки
            _buildProductCard(
              'Толстовка черная',
              'https://images.unsplash.com/photo-1556821840-3a63f95609a7?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '2500 ₽',
            ),
            _buildProductCard(
              'Толстовка серая',
              'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '2300 ₽',
            ),
            _buildProductCard(
              'Толстовка белая',
              'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '2400 ₽',
            ),
            _buildProductCard(
              'Толстовка с капюшоном',
              'https://images.unsplash.com/photo-1620799139834-6b8f844fbe61?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '2800 ₽',
            ),
            // Футболки
            _buildProductCard(
              'Футболка базовая',
              'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '1200 ₽',
            ),
            _buildProductCard(
              'Футболка поло',
              'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '1500 ₽',
            ),
            _buildProductCard(
              'Футболка оверсайз',
              'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '1400 ₽',
            ),
            _buildProductCard(
              'Футболка с принтом',
              'https://images.unsplash.com/photo-1622445275463-afa2ab738c34?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
              '1600 ₽',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, String imageUrl, String price) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение товара
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Информация о товаре
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
