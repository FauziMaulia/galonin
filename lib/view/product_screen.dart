import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodel/provider/login_provider.dart';
import '../viewmodel/provider/products_provider.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context, listen: false);
    viewModel.fetchProducts();
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return FutureBuilder<Widget>(
          future: _getProductWidget(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return snapshot.data ?? Container();
            }
          },
        );
      },
    );
  }

  Future<Widget> _getProductWidget() async {
    // Ambil userId dari SharedPreferences
    return  Container(
        padding: const EdgeInsets.all(16.0),
          child: Consumer<ProductViewModel>(
            builder: (context, productViewModel, child) {
              if (productViewModel.products.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: productViewModel.products.length,
                        itemBuilder: (context, index) {
                          final product = productViewModel.products[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 8.0),
                                  Expanded(
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(                                
                                    '${product.nama}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        minimumSize: const Size(120, 25),
                                      ),
                                      child: const Text('+ Keranjang'),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              }
            },
        ),
      );// Ganti dengan widget atau halaman yang ingin ditampilkan dengan userId
  }
}
