import 'package:flutter/foundation.dart';
import 'package:miniproject/models/api/orders_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/order.dart';

class OrdersProvider with ChangeNotifier {
 OrderService orderService = OrderService();
  List<Order> _orders = [];
  String _status ='Semua';

  
  List<Order> get orders => _orders;
  String get status => _status;
  Future fetchOrdersByUserId() async {
    try {
      _orders = await orderService.getOrdersByUserId();
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  Future MakeOrder(Order order) async {
    try {
      await orderService.createOrder(order);
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

   void changestatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }
}
