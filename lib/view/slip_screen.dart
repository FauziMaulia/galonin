import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/models/order.dart';
import 'package:miniproject/viewmodel/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodel/provider/cart_provider.dart';

class PaymentSlip extends StatefulWidget {
  const PaymentSlip({Key? key}) : super(key: key);

  @override
  _PaymentSlipState createState() => _PaymentSlipState();
}

class _PaymentSlipState extends State<PaymentSlip> {
  final NumberFormat formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
  final CartViewModel cartViewModel = CartViewModel();

  @override
  Widget build(BuildContext context) {
    const double deliveryFee = 15000.0;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Consumer<CartViewModel>(
          builder: (_, cartViewModel, __) {
            cartViewModel.fetchCartItems();
              return cartViewModel.cartItems.isEmpty ? const Center(child: Text('No items in cart')) : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24.0),
                    const Text('Order Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0),
                    Column(
                      children: cartViewModel.cartItems.map((item) => 
                        Card(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    item.imageUrl!,
                                    width: 64,
                                    height: 64,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.nama!,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        formatter.format(item.price!),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Quantity: ${item.amount}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      formatter.format(item.price! * item.amount),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                    const Divider(height: 32.0, thickness: 1.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                        Text(
                          formatter.format(cartViewModel.cartItems.fold(0.0, (previousValue, item) => previousValue + (item.price! * item.amount))),
                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Fee', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                        Text(
                          formatter.format(deliveryFee),
                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(height: 32.0, thickness: 1.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Text(
                          formatter.format(cartViewModel.cartItems.fold(0.0, (previousValue, item) => previousValue + (item.price! * item.amount)) + deliveryFee),
                          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    const Divider(height: 32.0, thickness: 1.0),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            );
          },
      ),
      bottomNavigationBar:Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        return BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int userId = prefs.getInt('userId') ?? 0;
                double total = deliveryFee;                
                for (var item in cartViewModel.cartItems) {
                    total += item.amount * item.price!;
                  }

                Order order = Order(
                  userId: userId,
                  totalPay: total.toInt(),
                  status: 'Menunggu Pembayaran',
                  orderItems: cartViewModel.cartItems.toList(),
                );
               
                OrdersProvider ordersProvider =OrdersProvider();
                ordersProvider.MakeOrder(order);
                if (context.mounted) {
                  cartViewModel.removeAllItemFromCart();
                  cartViewModel.fetchCartItems();
                  Navigator.pushNamedAndRemoveUntil(context, '/pesanan' , (route) => false);
                }
              },
              child: const Text('Bayar'),
            ),
          ),
        );
      },
    ),
    );
  }
}