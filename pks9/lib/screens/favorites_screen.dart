import 'package:flutter/material.dart';
import '../models/favorite.dart';
import '../services/product_service.dart';

class FavoritesScreen extends StatefulWidget {
  final String customerId;

  FavoritesScreen({required this.customerId});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ProductService _productService = ProductService();
  List<Favorite> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final favorites = await _productService.getFavorites(widget.customerId);
      setState(() {
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки избранного: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_favorites.isEmpty) {
      return Center(
        child: Text('В избранном пока ничего нет'),
      );
    }

    return ListView.builder(
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        final favorite = _favorites[index];
        final product = favorite.product;
        if (product == null) return SizedBox();

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: product.imageUrl.isNotEmpty
                ? Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.image),
            title: Text(product.name),
            subtitle: Text('${product.price} ₽'),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {
                try {
                  await _productService.addToCart(
                    widget.customerId,
                    product.id,
                    1,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Товар добавлен в ��орзину')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка добавления в корзину: $e')),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
