import 'package:flutter/material.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/favorites_page.dart';
import 'package:shop/pages/profile_page.dart';
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

  void toggleFavorite(FormItem item) {
    setState(() {
      if (favoriteItems.contains(item)) {
        favoriteItems.remove(item);
      } else {
        favoriteItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSKA Uniform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFf0f0ff),
      ),
      home: MyHomePage(
        favoriteItems: favoriteItems,
        onFavoriteToggle: toggleFavorite,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<FormItem> favoriteItems;
  final Function(FormItem) onFavoriteToggle;

  MyHomePage({required this.favoriteItems, required this.onFavoriteToggle});

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
      ),
      FavoritesPage(favoriteItems: widget.favoriteItems),
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
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
