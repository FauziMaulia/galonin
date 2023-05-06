import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/products.dart';
import '../product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String nama;
  final int price;
  final String brand;
  final int size;
  final int productId;
  final NumberFormat formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  ProductItem({super.key, 
    required this.imageUrl,
    required this.nama,
    required this.price,
    required this.brand,
    required this.productId,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child:  InkWell(
        onTap: () {
          Product myProduct = Product(productId: productId, brand: brand, size: size, imageUrl: imageUrl, price: price, nama: nama);
                  // Navigasi ke halaman detail produk
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: myProduct),
                    ),
                  );
        },
        child:Column(
        children: <Widget>[
          Container(
            height: 120,
            width: 120,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            nama,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            formatter.format(price),
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
      )
    );
  }
}