import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../order.dart';

class OrderService {
  final Dio _dio = Dio();
  final String url ='http://192.168.2.106:4000/api/orders'; 

  Future<List<Order>> getOrdersByUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('userId') ?? 0;
      final response = await _dio.get('$url?userid=$userId');
      List<Order> orders = [];

      for (var orderJson in response.data) {
        Order order = Order.fromJson(orderJson);
        orders.add(order);
      }
      return orders;
    } catch (error) {
      throw Exception('Failed to load orders by user ID:');
    }
  }

   Future<Order> createOrder(Order order) async {
    try {
      final response = await _dio.post(
        url,
        data: order.toJson(),
      );
      return Order.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}
