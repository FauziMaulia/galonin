import 'package:flutter/material.dart';
import 'package:miniproject/view/all_product_screen.dart';
import 'package:miniproject/view/user_screen.dart';
import 'package:provider/provider.dart';
import '../viewmodel/provider/home_provider.dart';
import 'product_screen.dart';
import 'component/sidebar.dart';
import 'orders_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<BottomNavigationViewModel>(
      create: (_) => BottomNavigationViewModel(),
      child: Scaffold(
        appBar: AppBar( 
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
          ]),
          drawer: Sidebar(),
        body: Consumer<BottomNavigationViewModel>(
          builder: (context, viewModel, _) {
            return Center(
              child: _getWidgetForIndex(viewModel.selectedIndex),
            );
          },
        ),
        bottomNavigationBar: Consumer<BottomNavigationViewModel>(
          builder: (context, viewModel, _) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Riwayat',
                ),
              ],
              currentIndex: viewModel.selectedIndex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                viewModel.updateSelectedIndex(index);
              },
            );
          },
        ),
      ),
    );
  }

 Widget _getWidgetForIndex(int index) {
  switch (index) {
    case 0:
   
      return HomePage();
    case 1:
      return OrdersHistory(); // Ganti dengan widget atau halaman untuk Profile
    default:
      return const Text('Unknown Tab');
  }
}



}
