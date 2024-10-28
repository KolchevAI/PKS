class Product {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

final List<Product> demoProducts = [
  Product(
    id: '1',
    title: 'Домашняя форма сезон 2024/25',
    description: 'Домашняя форма команды ПФК ЦСКА на сезон 2024/25',
    price: 6500,
    imageUrl: 'assets/images/home_24-25.png',
  ),
  Product(
    id: '2',
    title: 'Гостевая форма сезон 2024/25',
    description: 'Гостевая форма команды ПФК ЦСКА на сезон 2024/25',
    price: 6500,
    imageUrl: 'assets/images/away_24-25.png',
  ),
  Product(
    id: '3',
    title: 'Резервная форма сезон 2024/25',
    description: 'Резервная форма команды ПФК ЦСКА на сезон 2024/25',
    price: 6500,
    imageUrl: 'assets/images/res_24-25.png',
  ),
  Product(
    id: '4',
    title: 'Домашняя форма сезон 2023/24',
    description: 'Домашняя форма команды ПФК ЦСКА на сезон 2023/24',
    price: 8000,
    imageUrl: 'assets/images/home_23-24.png',
  ),
  Product(
    id: '5',
    title: 'Гостевая форма сезон 2023/24',
    description: 'Гостевая форма команды ПФК ЦСКА на сезон 2023/24',
    price: 8000,
    imageUrl: 'assets/images/away_23-24.png',
  ),
  Product(
    id: '6',
    title: 'Домашняя форма сезон 2022/23',
    description: 'Домашняя форма команды ПФК ЦСКА на сезон 2022/23',
    price: 10000,
    imageUrl: 'assets/images/home_22-23.png',
  ),
  Product(
    id: '7',
    title: 'Гостевая форма сезон 2022/23',
    description: 'Гостевая форма команды ПФК ЦСКА на сезон 2022/23',
    price: 10000,
    imageUrl: 'assets/images/away_22-23.png',
  ),
  Product(
    id: '8',
    title: 'Домашняя форма сезон 2021/22',
    description: 'Домашняя форма команды ПФК ЦСКА на сезон 2021/22',
    price: 11500,
    imageUrl: 'assets/images/home_21-22.png',
  ),
  Product(
    id: '9',
    title: 'Гостевая форма сезон 2021/22',
    description: 'Гостевая форма команды ПФК ЦСКА на сезон 2021/22',
    price: 11500,
    imageUrl: 'assets/images/away_21-22.png',
  ),
];