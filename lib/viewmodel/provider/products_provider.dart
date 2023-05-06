import 'package:flutter/foundation.dart';
import '../../models/api/products_services.dart';
import '../../models/products.dart';

class ProductViewModel with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  String _brand ='Semua';

  List<Product> get products => _products;
  String get brand => _brand;
  Future<void> fetchProducts() async {
    try {
      final products = await _productService.fetchProducts();
      _products = products;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> fetchProductsByProductId(int productId) async {
    try {
      final Product product = await _productService.fetchProductsByProductId(productId);
      notifyListeners();
      print(product.nama);
      return product;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<void> changebrand(String newbrand) async {
      _brand = newbrand;
      await fetchProducts(); 

      notifyListeners(); 
  }
}
