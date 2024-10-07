import 'package:flutter/material.dart';
import 'package:shop/module/data.dart';

class ProductCard extends StatelessWidget {
  final FormItem item;
  final bool isFavorite;
  final Function() onFavoriteToggle;
  final Function() onTap;

  ProductCard({
    required this.item,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey, width: 0.2),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              item.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}