import 'package:flutter/foundation.dart';
import '../../models/api/products_services.dart';
import '../../models/products.dart';

class ProductViewModel with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      final products = await _productService.fetchProducts();
      _products = products;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
