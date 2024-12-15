import 'product.dart';

class Favorite {
  final String id;
  final String customerId;
  final String productId;
  final DateTime createdAt;
  final Product? product;

  Favorite({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.createdAt,
    this.product,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      customerId: json['customer_id'],
      productId: json['product_id'],
      createdAt: DateTime.parse(json['created_at']),
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'product_id': productId,
        'created_at': createdAt.toIso8601String(),
        if (product != null) 'product': product!.toJson(),
      };
}
