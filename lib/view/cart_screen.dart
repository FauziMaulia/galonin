import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../viewmodel/provider/cart_provider.dart';
import 'empty_cart_Screen.dart';

class CartView extends StatelessWidget {
  CartViewModel cartViewModel =CartViewModel();
  bool isEmptyCart = true;
  CartView({Key? key});

  @override
  Widget build(BuildContext context) {
     final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cartViewModel, child) {
          if (cartViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if (cartViewModel.cartItems.isEmpty) {
            cartViewModel.fetchCartItems();
            return const EmptyCartPage();
          } else {
            cartViewModel.fetchCartItems();
            return ListView.builder(
              itemCount: cartViewModel.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartViewModel.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 140.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                              child:Column(
                                children: [
                                  const SizedBox(height: 20,),
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(cartItem.imageUrl!),
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            ),
                          
                        Padding(
                          padding: const EdgeInsets.only(right: 20,left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0),
                              Text(
                                '${cartItem.nama}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                formatCurrency.format(cartItem.price),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                              ), 
                              const SizedBox(height: 30.0),
                              Container(
                               decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                height: 27,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              
                               ElevatedButton(
                                  onPressed: () async {
                                    if(cartItem.amount<=1){
                                      bool shouldDelete = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Hapus Product Dari Cart"),
                                          content: const Text("Apakah anda yakin ingin menghapus cart ini?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, false),
                                              child: const Text("Tidak"),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, true),
                                              child: const Text("Ya"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (shouldDelete != null && shouldDelete) {
                                      print(cartItem.cartId);
                                      cartViewModel.deleteCart(cartItem.cartId!,cartItem.productId);
                                      cartViewModel.fetchCartItems();
                                    }
                                    }else{
                                    cartViewModel.decrementCart(cartItem.productId);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape:const ContinuousRectangleBorder() ,
                                    padding: const EdgeInsets.all(1),
                                    backgroundColor: Colors.blue[100],
                                    minimumSize: const Size(0, 10),

                                  ),
                                  child: const Icon(Icons.remove),
                                ),
                                Text('${cartItem.amount}'),
                                
                                ElevatedButton(
                                  onPressed: () async {
                                    await cartViewModel.incrementCart(cartItem.productId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape:const RoundedRectangleBorder(),
                                    padding: const EdgeInsets.all(1),
                                    backgroundColor: Colors.blue[100],
                                    minimumSize: const Size(0, 10),
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                              ],
                             )
                            ),
                              
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                       Flexible(
                        child: ElevatedButton(
                                 onPressed: () async {
                                    bool shouldDelete = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Hapus Product Dari Cart"),
                                          content: const Text("Apakah anda yakin ingin menghapus cart ini?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, false),
                                              child: const Text("Tidak"),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, true),
                                              child: const Text("Ya"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (shouldDelete != null && shouldDelete) {
                                      print(cartItem.cartId);
                                      cartViewModel.deleteCart(cartItem.cartId!,cartItem.productId);
                                      cartViewModel.fetchCartItems();
                                    }
                                  },

                                  style: ElevatedButton.styleFrom(
                                    shape:const CircleBorder() ,
                                    padding: const EdgeInsets.all(2),
                                    backgroundColor: Colors.red,
                                    minimumSize: const Size(0, 10),

                                  ),
                                  child: const Icon(Icons.delete),
                                ),
                       )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar:  Consumer<CartViewModel>(
          builder: (_, cartViewModel, __) {
              return cartViewModel.cartItems.isEmpty?
             const BottomAppBar( 
      
             ):
             BottomAppBar(
              child: 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                       Navigator.pushNamed(context,'/Struck');
                       print('cek');
                      },
                      child: const Text('Check Out'),
                    ),
                  ),
            );
          },
      )
    );
  }
}
