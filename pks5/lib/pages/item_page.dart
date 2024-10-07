import 'package:flutter/material.dart';
import 'package:shop/module/data.dart';

class ItemPage extends StatelessWidget {
  final FormItem item;

  const ItemPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name, style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0007d4),
      ),
      body: SingleChildScrollView( // Оборачиваем в SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                item.image,
                height: 300, // Уменьшаем высоту изображения для предотвращения переполнения
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
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
