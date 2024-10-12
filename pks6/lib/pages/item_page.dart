import 'package:flutter/material.dart';
import 'package:shop/module/data.dart';

class ItemPage extends StatelessWidget {
  final FormItem item;
  final bool isFavorite;
  final Function(FormItem) onFavoriteToggle;
  final Function(FormItem) onAddToCart;

  const ItemPage(
      {Key? key,
      required this.item,
      required this.onFavoriteToggle,
      required this.onAddToCart,
      required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              onFavoriteToggle(item);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Товар добавлен в избранное'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              onAddToCart(item);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Товар добавлен в корзину'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                item.image,
                height: 300,
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              item.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              item.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Цена: ${item.price.toStringAsFixed(2)} руб.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
