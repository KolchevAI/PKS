import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';
import '../model/favorite.dart';
import '../model/cart_item.dart';
import '../model/order.dart';

class ProductService {
  static const String baseUrl = 'http://localhost:8080/api';

  // Получение всех продуктов
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Работа с избранным
  Future<List<Favorite>> getFavorites(String customerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorites?customer_id=$customerId'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Favorite.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<Favorite> addToFavorites(String customerId, String productId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/favorites'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'customer_id': customerId,
        'product_id': productId,
      }),
    );
    if (response.statusCode == 200) {
      return Favorite.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add to favorites');
    }
  }

  // Работа с корзиной
  Future<List<CartItem>> getCart(String customerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cart?customer_id=$customerId'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CartItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<CartItem> addToCart(
      String customerId, String productId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'customer_id': customerId,
        'product_id': productId,
        'quantity': quantity,
      }),
    );
    if (response.statusCode == 200) {
      return CartItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add to cart');
    }
  }

  Future<bool> removeFromCart(String customerId, String productId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/cart'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'customer_id': customerId,
        'product_id': productId,
      }),
    );
    return response.statusCode == 200;
  }

  Future<CartItem> updateCartItemQuantity(
      String customerId, String productId, int quantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cart'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'customer_id': customerId,
        'product_id': productId,
        'quantity': quantity,
      }),
    );
    if (response.statusCode == 200) {
      return CartItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update cart item quantity');
    }
  }

  Future<bool> clearCart(String customerId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/cart/clear'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'customer_id': customerId,
      }),
    );
    return response.statusCode == 200;
  }

  // Работа с заказами
  Future<List<Order>> getOrders(String customerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/orders?customer_id=$customerId'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );
    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  // Обновление продукта
  Future<Product> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<bool> deleteProduct(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/products/$id'),
    );
    return response.statusCode == 200;
  }
}
