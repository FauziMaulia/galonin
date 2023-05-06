import 'package:flutter/material.dart';
import 'package:miniproject/models/api/cart_services.dart';
import 'package:miniproject/models/cart.dart';
import 'package:miniproject/view/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/products.dart';
import '../viewmodel/provider/cart_provider.dart';
import '../viewmodel/provider/order_provider.dart';
import '../viewmodel/provider/products_provider.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);

  @override
  _AllProductPageState createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  late CartViewModel cartViewModel = CartViewModel();
  late OrdersProvider ordersProvider;

  

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context, listen: false);
    viewModel.fetchProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
         actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
          ]
      ),
      body: Column(
        children: [
          const SizedBox(height:20),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTab('Semua', () => viewModel.changebrand('Semua')),
                _buildTab('Aqua', () => viewModel.changebrand('Aqua')),
                _buildTab('Vit', () => viewModel.changebrand('Vit')),
                _buildTab('Le Minerale', () => viewModel.changebrand('Le Minerale')),
              ],
            ),
          ),
          Expanded(
            child:FutureBuilder<Widget>(
        future: _getAllProductWidget(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return snapshot.data ?? Container();
          }
        },
      ),
          )
      ])
    );
  }

  Future<Widget> _getAllProductWidget() async {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<ProductViewModel>(
        builder: (context, productViewModel, child) {
          if (productViewModel.products.isEmpty) {
            cartViewModel.fetchCartItems();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Product> products = []; 
            if(productViewModel.brand=='Semua'){
                products = productViewModel.products;
            }else{
              for (var product in productViewModel.products) {
                      if (product.brand == productViewModel.brand) {
                        products.add(product);
                      }
                    }
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Product myProduct = Product(
                        productId: product.productId,
                        brand: product.brand,
                        size: product.size,
                        imageUrl: product.imageUrl,
                        price: product.price,
                        nama: product.nama,
                      );
                      // Navigasi ke halaman detail produk
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: myProduct),
                        ),
                      );
                    },
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
                            product.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Consumer<CartViewModel>(
                              builder: (context, cartViewModel, child) {
                                cartViewModel.fetchCartItems;
                                cartViewModel.InCart(product.productId);
                                return cartViewModel.cartProductId.contains(product.productId)
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text('Product sudah ada dalam cart'),
                                            duration: Duration(seconds: 2),
                                          ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white70,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          minimumSize: const Size(120, 25),
                                        ),
                                        child: const Text(
                                          '+ Keranjang',
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () async {
                                          // Tambahkan logika untuk menambahkan product ke dalam cartList
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          int userId = prefs.getInt('userId')!;

                                          final cart = Cart(
                                            userId: userId,
                                            productId: product.productId,
                                            amount: 1,
                                          );
                                          cartViewModel.addItemToCart(cart).then((_) {
                                            // Menampilkan snackbar ketika cart berhasil ditambahkan
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text('Product berhasil ditambahkan ke dalam cart'),
                                              duration: Duration(seconds: 2),
                                            ));
                                            cartViewModel.fetchCartItems();
                                          }).catchError((error) {
                                            // Menampilkan snackbar ketika terjadi error ketika menambahkan cart
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text('Terjadi kesalahan saat menambahkan product ke dalam cart'),
                                              duration: Duration(seconds: 2),
                                            ));
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          minimumSize: const Size(120, 25),
                                        ),
                                        child: const Text('+ Keranjang'),
                                      );
                              },
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
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

  Widget _buildTab(String title, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Consumer<ProductViewModel>(
        builder: (context, productViewModel, child) {
            return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: productViewModel.brand == title ? Colors.blue : Colors.grey,
            borderRadius: const BorderRadius.only(bottomLeft:Radius.elliptical(40, 10), bottomRight: Radius.elliptical(40, 10) ),
            
          ),
          child: Text(
            title,
            style: TextStyle(
              color: productViewModel.brand == title ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        },
    )
  );
}
}