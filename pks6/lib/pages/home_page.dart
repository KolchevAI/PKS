import 'package:flutter/material.dart';
import 'item_page.dart';
import 'package:shop/module/data.dart';
import 'package:shop/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  final List<FormItem> favoriteItems;
  final Function(FormItem) onFavoriteToggle;
  final Function(FormItem) onAddToCart;

  HomePage({
    required this.favoriteItems,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 1.0,
          childAspectRatio: 0.5,
        ),
        itemCount: formItems.length,
        itemBuilder: (context, index) {
          final item = formItems[index];
          return ProductCard(
            item: item,
            isFavorite: widget.favoriteItems.contains(item),
            onFavoriteToggle: () {
              setState(() {
                widget.onFavoriteToggle(item);
              });
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemPage(
                    item: item,
                    isFavorite: widget.favoriteItems.contains(item),
                    onFavoriteToggle: widget.onFavoriteToggle,
                    onAddToCart: widget.onAddToCart,
                  ),
                ),
              );
            },
            onAddToCart: () {
              widget.onAddToCart(item);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} добавлен в корзину')),
              );
            },
          );
        },
      ),
    );
  }
}
