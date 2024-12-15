import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/product_service.dart';

class OrdersScreen extends StatefulWidget {
  final String customerId;

  OrdersScreen({required this.customerId});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ProductService _productService = ProductService();
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final orders = await _productService.getOrders(widget.customerId);
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки заказов: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_orders.isEmpty) {
      return Center(
        child: Text('У вас пока нет заказов'),
      );
    }

    return ListView.builder(
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpansionTile(
            title: Text('Заказ №${order.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Статус: ${order.status}'),
                Text(
                  'Сумма: ${order.totalPrice} ₽',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Дата: ${order.createdAt.toLocal().toString().split('.')[0]}',
                ),
              ],
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: order.items.length,
                itemBuilder: (context, itemIndex) {
                  final item = order.items[itemIndex];
                  final product = item.product;
                  if (product == null) return SizedBox();

                  return ListTile(
                    leading: product.imageUrl.isNotEmpty
                        ? Image.network(
                            product.imageUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image),
                    title: Text(product.name),
                    subtitle: Text('${item.price} ₽ x ${item.quantity}'),
                    trailing: Text(
                      '${item.price * item.quantity} ₽',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
