import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductSelect {
  final String baseUrl;

  ProductSelect({required this.baseUrl});

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/data'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
