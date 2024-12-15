import 'product.dart';

class CartItem {
  final String id;
  final String customerId;
  final String productId;
  final int quantity;
  final DateTime createdAt;
  final Product? product;

  CartItem({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      customerId: json['customer_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'product_id': productId,
        'quantity': quantity,
        'created_at': createdAt.toIso8601String(),
        if (product != null) 'product': product!.toJson(),
      };
}
