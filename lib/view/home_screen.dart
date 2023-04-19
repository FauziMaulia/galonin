import 'package:flutter/material.dart';
import 'package:miniproject/view/product_screen.dart';
import 'package:miniproject/view/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodel/provider/home_provider.dart';
import '../viewmodel/provider/login_provider.dart';


class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<BottomNavigationViewModel>(
      create: (_) => BottomNavigationViewModel(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Panggil fungsi logout saat tombol logout ditekan
                Provider.of<LoginProvider>(context, listen: false).logout();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ]),
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
                  icon: Icon(Icons.shopping_cart),
                  label: 'Product',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
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
   
      return ProductWidget();
    case 1:
      return const Text('Riwayat'); // Ganti dengan widget atau halaman untuk Riwayat
    case 2:
      return UserDetailView(); // Ganti dengan widget atau halaman untuk Profile
    default:
      return const Text('Unknown Tab');
  }
}



}
