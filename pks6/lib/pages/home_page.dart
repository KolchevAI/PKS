import 'package:flutter/material.dart';
import '../widgets/item.dart';
import '../model/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 элемента в ряд
          mainAxisSpacing: 10, // Отступ между рядами
          crossAxisSpacing: 10, // Отступ между колонками
          childAspectRatio: 0.6, // Соотношение сторон карточки
        ),
        itemCount: demoProducts.length,
        itemBuilder: (context, index) {
          return ItemCard(
            product: demoProducts[index],
          );
        },
      ),
    );
  }
}