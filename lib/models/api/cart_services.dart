import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cart.dart';


class CartService {
  final String apiUrl = 'https://galonin.temanhorizon.com/api/cart'; 

  final dio = Dio();
Future<void> incrementCart( int productId) async {
    try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;
      final response = await dio.patch(
        'https://galonin.temanhorizon.com/api/cart/increment',
        data: jsonEncode({
          'user_id': userId,
          'product_id': productId,
        }),
      );

      if (response.statusCode == 200) {
        print(response.data['message']);
      } else {
        print('Terjadi kesalahan saat mengakses API');
      }
    } catch (error) {
      print('Terjadi kesalahan saat mengakses API: $error');
    }
  }

  Future<void> decrementCart( int productId) async {
    try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;
    
      final response = await dio.patch(
        'https://galonin.temanhorizon.com/api/cart/decrement',
        data: jsonEncode({
          'user_id': userId, 
          'product_id': productId,
        }),
      );

      if (response.statusCode == 200) {
        print(response.data['message']);
      } else {
        print('Terjadi kesalahan saat mengakses API');
      }
    } catch (error) {
      print('Terjadi kesalahan saat mengakses API: $error');
    }
  }

  Future<List<Cart>> getCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;

    final response = await dio.get(apiUrl+'?user_id=$userId');
    if (response.statusCode == 200) { 
     final List<dynamic> jsonList = response.data as List<dynamic>; 
     final a = jsonList.map((json) => Cart.fromJson(json)).toList();
      return a;
    } else {
      throw Exception('Failed to load cart list');
    }
  }
  Future<Cart> getCartByProductId(int ProductId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;

    final response = await dio.get(apiUrl+'?user_id=$userId&product_id=$ProductId');
    if (response.statusCode == 200) { 
     final List<dynamic> jsonList = response.data; 
     Cart cart = Cart(
      cartId: response.data['cart_id'],
      userId: response.data['user_id'],
      productId: response.data['product_id'],
      amount: response.data['amount'],
      brand: response.data['brand'],
      size: response.data['size'],
      imageUrl: response.data['imageUrl'],
      price: response.data['price'],
      nama: response.data['nama'],
     );
      return cart;
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

  Future<void> deleteCart(int cartId) async {
    final url = '$apiUrl/$cartId';
    print(url);
    final response = await dio.delete(url);
    print(response.data);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cart');
    }
  }

   Future<void> deleteAllCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;

    final response = await dio.delete('$apiUrl/all/$userId');
    print(response.data);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cart');
    }
  }
}

