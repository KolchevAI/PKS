import 'package:flutter/material.dart';
import 'item_page.dart';
import 'package:shop/module/data.dart';
import 'add_item_page.dart';
import 'package:shop/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  final List<FormItem> favoriteItems;
  final Function(FormItem) onFavoriteToggle;

  HomePage({required this.favoriteItems, required this.onFavoriteToggle});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 50,
            ),
            SizedBox(width: 10),
            Text(
              'CSKA Uniform',
              style: TextStyle(fontSize: 24, color: Color(0xFFfffafa)),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0007d4),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7, // Изменяем соотношение сторон для большего изображения
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
                    builder: (context) => ItemPage(item: item),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemPage(onItemAdded: (newItem) {
              setState(() {
                formItems.add(newItem); // Добавляем новый товар в список
              });
            })),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
