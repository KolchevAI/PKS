import 'package:flutter/material.dart';
import 'products_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'orders_screen.dart';

class MainScreen extends StatefulWidget {
  final String
      customerId; // В реальном приложении это будет получено после авторизации

  MainScreen({required this.customerId});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранн��е',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Заказы',
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Товары';
      case 1:
        return 'Избранное';
      case 2:
        return 'Корзина';
      case 3:
        return 'Заказы';
      default:
        return 'Магазин';
    }
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return ProductsScreen();
      case 1:
        return FavoritesScreen(customerId: widget.customerId);
      case 2:
        return CartScreen(customerId: widget.customerId);
      case 3:
        return OrdersScreen(customerId: widget.customerId);
      default:
        return ProductsScreen();
    }
  }
}
