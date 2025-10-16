import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pandyt_app/pages/products/models/product_model.dart';

class ProductService {
  static const String baseUrl =
      'https://dummyjson.com/products?limit=10&select=title,price';

  Future<List<Product>> fetchProducts({int skip = 0}) async {
    final url = Uri.parse('$baseUrl&skip=$skip');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
