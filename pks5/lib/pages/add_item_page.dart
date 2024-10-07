import 'package:flutter/material.dart';
import 'package:shop/module/data.dart';

class AddItemPage extends StatefulWidget {
  final Function(FormItem) onItemAdded;

  AddItemPage({required this.onItemAdded});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? imagePath; // Добавим поле для хранения изображения

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить товар'),
        backgroundColor: const Color(0xFF0007d4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Описание'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FormItem newItem = FormItem(
                  name: nameController.text,
                  image: 'assets/images/new.png', // Временно используем заглушку
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                );
                widget.onItemAdded(newItem);
                Navigator.pop(context);
              },
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
