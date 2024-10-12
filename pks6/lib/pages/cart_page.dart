import 'package:flutter/material.dart';
import 'package:shop/module/data.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(CartItem) onRemoveFromCart;

  CartPage({required this.cartItems, required this.onRemoveFromCart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _incrementQuantity(CartItem cartItem) {
    setState(() {
      cartItem.quantity++;
    });
  }

  void _decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      setState(() {
        cartItem.quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Корзина',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text('Ваша корзина пуста'),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cartItems[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    widget.onRemoveFromCart(cartItem);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('${cartItem.item.name} удален из корзины')));
                  },
                  child: ListTile(
                    leading: Image.asset(cartItem.item.image, width: 50),
                    title: Text(cartItem.item.name),
                    subtitle: Text(
                        'Цена: ${cartItem.item.price.toStringAsFixed(2)} руб.'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(cartItem),
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _incrementQuantity(cartItem),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Оформить заказ',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
