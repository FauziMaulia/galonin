import 'package:dio/dio.dart';

import '../products.dart';

class ProductService {
  static const String apiUrl = 'https://galonin.temanhorizon.com/api/products';

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

  Future<Product> fetchProductsByProductId(int id) async {
    try {
      Dio dio = Dio();
      final response = await dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        final productsJson = response.data['data'];
       Product product = Product(
        productId: productsJson['product_id'],
        brand: productsJson['brand'], size: productsJson['size'],
        imageUrl: productsJson['imageUrl'], 
        price: productsJson['price'], 
        nama: productsJson['nama']);
        return product;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
