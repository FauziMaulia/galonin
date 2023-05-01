import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/provider/cart_provider.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key});

  @override
  Widget build(BuildContext context) {
    CartViewModel cartViewModel = CartViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: FutureBuilder(
        future: cartViewModel.fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else if (cartViewModel.cartItems.isEmpty) {
            return const Center(
              child: Text('Cart is empty'),
            );
          } else {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.5,
                ),
                itemCount: cartViewModel.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartViewModel.cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          Expanded(
                            child: Image.network(
                              cartItem.imageUrl!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8.0),
                                Text(
                                  '${cartItem.nama}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  'Price     : ${cartItem.price}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  'Jumlah : ${cartItem.amount}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cartViewModel.removeItemFromCart(cartItem.cartId!);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      minimumSize: const Size(120, 25),
                                    ),
                                    child: const Text('Remove from cart'),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
