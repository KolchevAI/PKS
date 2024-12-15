import 'product.dart';

class Order {
  final String id;
  final String customerId;
  final String status;
  final double totalPrice;
  final DateTime createdAt;
  final List<OrderProduct> items;

  Order({
    required this.id,
    required this.customerId,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      status: json['status'],
      totalPrice: json['total_price'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      items: (json['items'] as List?)
              ?.map((item) => OrderProduct.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'status': status,
        'total_price': totalPrice,
        'created_at': createdAt.toIso8601String(),
        'items': items.map((item) => item.toJson()).toList(),
      };
}

class OrderProduct {
  final String id;
  final String orderId;
  final String productId;
  final int quantity;
  final double price;
  final Product? product;

  OrderProduct({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    this.product,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'quantity': quantity,
        'price': price,
        if (product != null) 'product': product!.toJson(),
      };
}
