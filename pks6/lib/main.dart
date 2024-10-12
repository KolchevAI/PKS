// main.dart

import 'package:flutter/material.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/favorites_page.dart';
import 'package:shop/pages/profile_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/module/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<FormItem> favoriteItems = [];
  List<CartItem> cartItems = [];

  void toggleFavorite(FormItem item) {
    setState(() {
      if (favoriteItems.contains(item)) {
        favoriteItems.remove(item);
      } else {
        favoriteItems.add(item);
      }
    });
  }

  void addToCart(FormItem item) {
    setState(() {
      CartItem? existingItem = cartItems.firstWhere(
        (cartItem) => cartItem.item == item,
        orElse: () => CartItem(item: item, quantity: 0),
      );

      if (existingItem.quantity == 0) {
        cartItems.add(CartItem(item: item));
      } else {
        existingItem.quantity++;
      }
    });
  }

  void removeFromCart(CartItem cartItem) {
    setState(() {
      cartItems.remove(cartItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSKA Uniform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFf2f2f2),
      ),
      home: MyHomePage(
        favoriteItems: favoriteItems,
        cartItems: cartItems,
        onFavoriteToggle: toggleFavorite,
        onAddToCart: addToCart,
        onRemoveFromCart: removeFromCart,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<FormItem> favoriteItems;
  final List<CartItem> cartItems;
  final Function(FormItem) onFavoriteToggle;
  final Function(FormItem) onAddToCart;
  final Function(CartItem) onRemoveFromCart;

  MyHomePage({
    required this.favoriteItems,
    required this.cartItems,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.onRemoveFromCart,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        favoriteItems: widget.favoriteItems,
        onFavoriteToggle: widget.onFavoriteToggle,
        onAddToCart: widget.onAddToCart,
      ),
      FavoritesPage(favoriteItems: widget.favoriteItems),
      CartPage(
        cartItems: widget.cartItems,
        onRemoveFromCart: widget.onRemoveFromCart,
      ),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey[400],
        onTap: _onItemTapped,
      ),
    );
  }
}
