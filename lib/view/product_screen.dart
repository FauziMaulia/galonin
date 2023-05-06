import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/view/widget/product_widget.dart';
import 'package:provider/provider.dart';

import '../viewmodel/provider/products_provider.dart';
import 'all_product_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10,),
            const Text(' Best Seller',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            Padding(padding: const EdgeInsets.all(10),
            child:Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.elliptical(20, 30),bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.network(
                'https://ik.imagekit.io/waters2021/sehataqua/uploads/20200701075821_original.jpg?tr=f-auto',
                fit: BoxFit.cover,
              ),
            ),
            ),

            const SizedBox(height: 10),
            const Text(
              'Product',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child:Consumer<ProductViewModel>(
                      builder: (context, productViewModel, child) {
                        productViewModel.fetchProducts();
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: productViewModel.products.map((product) {
                            return ProductItem(
                              productId: product.productId,
                              imageUrl: product.imageUrl,
                              nama: product.nama,
                              price: product.price,
                              brand: product.brand,
                              size: product.size
                            );
                          }).toList(),
                      );
                  },
              ),

            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProductPage()));
                },
                child: const Text('See All Products'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

