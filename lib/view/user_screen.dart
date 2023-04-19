import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodel/provider/user_provider.dart';

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserViewModel>(context, listen: false);
    viewModel.getUserDetail();
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('ID Pengguna: ${userViewModel.user.userId}'),
                Text('Email: ${userViewModel.user.email}'),
                Text('Nama: ${userViewModel.user.nama}'),
                Text('Role: ${userViewModel.user.role}'),
                Text('Alamat: ${userViewModel.user.alamat}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
