import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart'; // Import Product model

class ApiService {
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> productJson = jsonDecode(response.body);
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
