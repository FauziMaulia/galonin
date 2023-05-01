import 'package:dio/dio.dart';

import '../products.dart';

class ProductService {
  static const String apiUrl = 'http://192.168.2.106:4000/api/products';

  Future<List<Product>> fetchProducts() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final productsJson = response.data['data'] as List<dynamic>;
        final products = productsJson.map((json) => Product.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
