import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../services/product_service.dart';

class CartScreen extends StatefulWidget {
  final String customerId;

  CartScreen({required this.customerId});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductService _productService = ProductService();
  List<CartItem> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final items = await _productService.getCart(widget.customerId);
      setState(() {
        _cartItems = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки корзины: $e')),
      );
    }
  }

  double get _totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.product?.price ?? 0) * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              return ListTile(
                leading: item.product?.imageUrl != null
                    ? Image.network(
                        item.product!.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image),
                title: Text(item.product?.name ?? 'Товар'),
                subtitle:
                    Text('${item.product?.price ?? 0} ₽ x ${item.quantity}'),
                trailing: Text(
                  '${(item.product?.price ?? 0) * item.quantity} ₽',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Итого:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_totalPrice} ₽',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _cartItems.isEmpty
                    ? null
                    : () {
                        // TODO: Реализовать оформление заказа
                      },
                child: Text('Оформить заказ'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
