import 'dart:convert';
import 'dart:typed_data';

class Product {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  final String season;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.season,
    this.isFavorite = false,
  });

  // Создание Product из JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    String decodeString(String input) {
      try {
        return utf8.decode(input.runes.toList());
      } catch (e) {
        return input;
      }
    }

    return Product(
      id: json['id'].toString(),
      title: decodeString(json['name'] ?? json['title']),
      description: decodeString(json['description']),
      price: (json['price'] as num).toInt(),
      imageUrl: json['image_url'] ?? json['imageUrl'],
      season: json['season'] ?? '23/24',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Преобразование Product в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'season': season,
      'isFavorite': isFavorite,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Функция для загрузки демо-продуктов из JSON строки
List<Product> loadProductsFromJson(String jsonString) {
  final Map<String, dynamic> data = json.decode(jsonString);
  final List<dynamic> productsJson = data['products'];
  return productsJson.map((json) => Product.fromJson(json)).toList();
}

// Демо-продукты теперь будут загружаться из JSON
final String jsonData = '''
{
  "products": [
    {
      "ID": 1,
      "Name": "Домашняя форма сезон 2024/25",
      "Description": "Домашняя форма команды ПФК ЦСКА на сезон 2024/25",
      "Price": 6500,
      "ImageURL": "assets/images/home_24-25.png",
      "Season": "2024/25"
    },
    {
      "ID": 2,
      "Name": "Гостевая форма сезон 2024/25",
      "Description": "Гостевая форма команды ПФК ЦСКА на сезон 2024/25",
      "Price": 6500,
      "ImageURL": "assets/images/away_24-25.png",
      "Season": "2024/25"
    },
    {
      "ID": 3,
      "Name": "Резервная форма сезон 2024/25",
      "Description": "Резервная форма команды ПФК ЦСКА на сезон 2024/25",
      "Price": 6500,
      "ImageURL": "assets/images/res_24-25.png",
      "Season": "2024/25"
    },
    {
      "ID": 4,
      "Name": "Домашняя форма сезон 2023/24",
      "Description": "Домашняя форма команды ПФК ЦСКА на сезон 2023/24",
      "Price": 8000,
      "ImageURL": "assets/images/home_23-24.png",
      "Season": "2023/24"
    },
    {
      "ID": 5,
      "Name": "Гостевая форма сезон 2023/24",
      "Description": "Гостевая форма команды ПФК ЦСКА на сезон 2023/24",
      "Price": 8000,
      "ImageURL": "assets/images/away_23-24.png",
      "Season": "2023/24"
    },
    {
      "ID": 6,
      "Name": "Домашняя форма сезон 2022/23",
      "Description": "Домашняя форма команды ПФК ЦСКА на сезон 2022/23",
      "Price": 10000,
      "ImageURL": "assets/images/home_22-23.png",
      "Season": "2022/23"
    },
    {
      "ID": 7,
      "Name": "Гостевая форма сезон 2022/23",
      "Description": "Гостевая форма команды ПФК ЦСКА на сезон 2022/23",
      "Price": 10000,
      "ImageURL": "assets/images/away_22-23.png",
      "Season": "2022/23"
    },
    {
      "ID": 8,
      "Name": "Домашняя форма сезон 2021/22",
      "Description": "Домашняя форма команды ПФК ЦСКА на сезон 2021/22",
      "Price": 11500,
      "ImageURL": "assets/images/home_21-22.png",
      "Season": "2021/22"
    },
    {
      "ID": 9,
      "Name": "Гостевая форма сезон 2021/22",
      "Description": "Гостевая форма команды ПФК ЦСКА на сезон 2021/22",
      "Price": 11500,
      "ImageURL": "assets/images/away_21-22.png",
      "Season": "2021/22"
    }
  ]
}
''';

// Инициализация демо-продуктов из JSON
final List<Product> demoProducts = loadProductsFromJson(jsonData); 