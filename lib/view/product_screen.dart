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
        padding: EdgeInsets.all(16.0),
          child: Consumer<ProductViewModel>(
            builder: (context, productViewModel, child) {
              if (productViewModel.products.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: productViewModel.products.length,
                  itemBuilder: (context, index) {
                    final product = productViewModel.products[index];
                    return ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.brand),
                      subtitle: Text('${product.size} ml'),
                      trailing: Text('Rp ${product.price}'),
                    );
                  },
                );
              }
            },
        ),
      );// Ganti dengan widget atau halaman yang ingin ditampilkan dengan userId
  }
}
