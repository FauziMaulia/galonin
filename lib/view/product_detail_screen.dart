import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/products.dart';
import '../viewmodel/provider/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  ProductDetailPage({required this.product, Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late CartViewModel cartViewModel = CartViewModel();
  List<int> cartProductId = [];
  bool isInCart = false;
  int? amount;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.brand),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.product.imageUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    widget.product.nama,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 8),
                  Text(
                    widget.formatCurrency.format(widget.product.price),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Size: ${widget.product.size} mL',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Deskripsi:',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Air galon merek ${widget.product.brand} dengan ukuran ${widget.product.size} mL adalah produk air mineral yang sangat populer di Indonesia. Air mineral ini dihasilkan dari proses penyaringan dan pemurnian yang ketat untuk memastikan kualitas air yang bersih dan sehat untuk diminum. Air galon Aqua 1,5 liter hadir dalam botol yang mudah dibawa dan praktis untuk dikonsumsi di rumah, kantor, atau di tempat lain.\n'
                  +'${widget.product.nama} liter memiliki harga sekitar${widget.product.price} rupiah per botolnya. Harga yang terjangkau ini membuat ${widget.product.nama} menjadi pilihan yang tepat bagi banyak orang yang mencari air mineral berkualitas dengan harga yang terjangkau.',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<CartViewModel>(
        builder: (context, cartViewModel, _) {
          cartViewModel.InCart(widget.product.productId);
          bool isInCart = cartViewModel.isInCart;
          return isInCart
              ? FloatingActionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Product Sudah ada dalam cart'),
                      duration: Duration(seconds: 2),
                    ));
                  },
                  backgroundColor: Colors.grey,
                  child: const Icon(Icons.shopping_cart),
                )
              : FloatingActionButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int userId = prefs.getInt('userId')!;

                    final cart = Cart(
                      userId: userId,
                      productId: widget.product.productId,
                      amount: 1,
                    );
                    cartViewModel.addItemToCart(cart).then((_) {
                      // Menampilkan snackbar ketika cart berhasil ditambahkan
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Product berhasil ditambahkan ke dalam cart'),
                        duration: Duration(seconds: 2),
                      ));
                      cartViewModel.fetchCartItems();
                      cartViewModel.InCart(widget.product.productId);
                    }).catchError((error) {
                      // Menampilkan snackbar ketika terjadi error ketika menambahkan cart
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Terjadi kesalahan saat menambahkan product ke dalam cart'),
                        duration: Duration(seconds: 2),
                      ));
                    });
                  },
                  child: const Icon(Icons.shopping_cart),
                );
        },
      ),
    );
  }
}