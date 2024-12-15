class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final DateTime createdAt;
  final int idNew;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.idNew,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      idNew: json['id_new'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
        'description': description,
        'price': price,
        'created_at': createdAt.toIso8601String(),
        'id_new': idNew,
      };
}
