import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/view/empty_order_Screen.dart';
import 'package:miniproject/viewmodel/provider/products_provider.dart';
import 'package:miniproject/viewmodel/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../viewmodel/provider/order_provider.dart';
import 'order_detail_screen.dart';

class OrdersHistory extends StatefulWidget {
  OrdersHistory({Key? key}) : super(key: key);

  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  UserViewModel userViewModel = UserViewModel();


  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    userViewModel.getUserDetail();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10,),
          SizedBox(
            height: 50.0,
            child:Consumer<OrdersProvider>(
                builder: (_, ordersProvider, __) {
                    return  ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildTab('Semua', () => ordersProvider.changestatus('Semua')),
                            _buildTab('Menunggu Pembayaran', () => ordersProvider.changestatus('Menunggu Pembayaran')),
                            _buildTab('Dalam Proses', () => ordersProvider.changestatus('Dalam Proses')),
                            _buildTab('Di Kirim', () => ordersProvider.changestatus('Di Kirim')),
                            _buildTab('Selesai', () => ordersProvider.changestatus('Selesai')),
                            _buildTab('Dibatalkan', () => ordersProvider.changestatus('Dibatalkan')),
                          ],
                        );
                },
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: Consumer<OrdersProvider>(
              builder: (context, ordersProvider, _) {
                ordersProvider.fetchOrdersByUserId();
                print('1${ordersProvider.status}');
                List<Order> filteredOrders = [];
                  if(ordersProvider.status=='Semua'){
                  filteredOrders = ordersProvider.orders;
                  }else {
                    for (var order in ordersProvider.orders) {
                      if (ordersProvider.status == order.status) {
                        filteredOrders.add(order);
                      }
                    }
                  }     
                if (filteredOrders.isEmpty) {
                  return const EmptyOrdersPage();
                } else {                   
                    return ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      Color statusColor = Colors.blue;
                      if (order.status == 'Dibatalkan') {
                        statusColor = Colors.red;
                      } else if (order.status == 'Selesai') {
                        statusColor = Colors.green;
                      }
                      return  InkWell(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailPage(order: order,),
                          ),
                        );
                        },
                        child:Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Order ID: ${order.orderId}'),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        formatter.format(order.totalPay),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Order Items: ${order.orderItems!.length}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${order.status}',
                                      style: TextStyle(
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      );
                    },
                  );
                  }
                  
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Consumer<OrdersProvider>(
        builder: (_, ordersProvider, __) {
          return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: ordersProvider.status == title ? Colors.blue : Colors.grey,
            borderRadius: const BorderRadius.only(topLeft:Radius.elliptical(20, 10), bottomRight: Radius.elliptical(10, 20) ),
            
          ),
          child: Text(
            title,
            style: TextStyle(
              color: ordersProvider.status == title ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        },
    )
  );
}
}