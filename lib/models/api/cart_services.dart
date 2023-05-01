import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cart.dart';


class CartService {
  final String apiUrl = 'http://192.168.2.106:4000/api/cart?user_id='; 

  final dio = Dio();

  Future<List<Cart>> getCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;

    final response = await dio.get(apiUrl+'$userId');
    if (response.statusCode == 200) { 
     final List<dynamic> jsonList = response.data as List<dynamic>; 
     final a = jsonList.map((json) => Cart.fromJson(json)).toList();
     print(jsonList);
     print(a);
      return a;
    } else {
      throw Exception('Failed to load cart list');
    }
  }

  Future<Cart> addCart(Cart cart) async {
    final response = await dio.post(apiUrl, data: cart.toJson());

    if (response.statusCode == 201) {
      final data = response.data;
      return Cart.fromJson(data);
    } else {
      throw Exception('Failed to add cart');
    }
  }

  Future<void> updateCart(Cart cart) async {
    final url = '$apiUrl/${cart.cartId}';
    final response = await dio.put(url, data: cart.toJson());

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart');
    }
  }

  Future<void> deleteCart(int cartId) async {
    final url = '$apiUrl/$cartId';
    final response = await dio.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cart');
    }
  }
}
