import 'package:flutter/material.dart';
import 'package:shop/module/data.dart';
import 'item_page.dart';
import 'package:shop/widgets/product_card.dart';

class FavoritesPage extends StatelessWidget {
  final List<FormItem> favoriteItems;

  FavoritesPage({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
        backgroundColor: const Color(0xFF0007d4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favoriteItems.isEmpty
            ? Center(child: Text('Избранных товаров нет.'))
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7, // Используем такое же соотношение сторон
          ),
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoriteItems[index];
            return ProductCard(
              item: item,
              isFavorite: true, // Все товары здесь уже избранные
              onFavoriteToggle: () {
                // Убираем из избранного при нажатии
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item.name} убран из избранного'),
                  ),
                );
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemPage(item: item),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
