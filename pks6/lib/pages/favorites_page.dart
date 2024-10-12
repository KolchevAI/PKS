import 'package:flutter/material.dart';
import 'package:shop/module/data.dart';
import 'package:shop/widgets/product_card.dart';

class FavoritesPage extends StatelessWidget {
  final List<FormItem> favoriteItems;

  FavoritesPage({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Избранное',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: favoriteItems.isEmpty
          ? Center(child: Text('Избранных товаров нет'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.5,
              ),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return ProductCard(
                  item: item,
                  isFavorite: true,
                  onFavoriteToggle: () {},
                  onTap: () {},
                  onAddToCart: () {},
                );
              },
            ),
    );
  }
}
