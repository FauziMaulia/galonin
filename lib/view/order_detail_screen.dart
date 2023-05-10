import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';
import '../models/products.dart';
import '../viewmodel/provider/products_provider.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    Color statusColor = Colors.blue;
                      if (order.status == 'Dibatalkan') {
                        statusColor = Colors.red;
                      } else if (order.status == 'Selesai') {
                        statusColor = Colors.green;
                      }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blueGrey.shade100,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${order.orderId}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'User ID: ${order.userId}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Order Items',
                     style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  FutureBuilder(
                    future: Future.wait(order.orderItems!.map((orderItem) async {
                      ProductViewModel productViewModel = ProductViewModel();
                      Product product = await productViewModel.fetchProductsByProductId(int.parse(orderItem['product_id']));
                      return {
                        'product': product,
                        'amount': orderItem['amount'],
                      };
                    }).toList()),
                    builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      List<Map<String, dynamic>> productsData = snapshot.data!;
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 1,
                        childAspectRatio: 2.5,
                        children: productsData.map((productData) {
                          final Product product = productData['product']!;
                          final int amount = productData['amount']!;
                          Color statusColor = Colors.blue;
                      if (order.status == 'Dibatalkan') {
                        statusColor = Colors.red;
                      } else if (order.status == 'Selesai') {
                        statusColor = Colors.green;
                      }
                          return Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 140.0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(25.0),
                                      bottomLeft: Radius.circular(25)
                                    ),
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.nama,
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                       const SizedBox(height: 4.0),
                                      Text(
                                        formatCurrency.format(product.price),
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 18.0,
                                          color:Colors.black38
                                        ),
                                        
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Size: ${product.size} mL',
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                     
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 8.0),
                                    Text(
                                        'x $amount',
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 20.0,
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Total Pay: ${formatCurrency.format(order.totalPay)}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        'Status: ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        order.status!,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: statusColor
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}