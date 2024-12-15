class Order {
  final String id;
  final String customerId;
  final List<OrderItem> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['ID'].toString(),
      customerId: json['CustomerID'].toString(),
      items: (json['Items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: (json['TotalAmount'] as num).toDouble(),
      status: json['Status'],
      createdAt: DateTime.parse(json['CreatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CustomerID': customerId,
      'Items': items.map((item) => item.toJson()).toList(),
      'TotalAmount': totalAmount,
      'Status': status,
      'CreatedAt': createdAt.toIso8601String(),
    };
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['ProductID'].toString(),
      quantity: json['Quantity'] as int,
      price: (json['Price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductID': productId,
      'Quantity': quantity,
      'Price': price,
    };
  }
}
