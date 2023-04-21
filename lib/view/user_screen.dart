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
        if (userViewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                  color: Colors.blue,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Profile', style: TextStyle(fontSize: 32, color: Colors.white)),
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(userViewModel.user.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      userViewModel.user.nama,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Masukkan email',
                        ),
                        controller: TextEditingController(text: userViewModel.user.email),
                        onChanged: (value) {
                          userViewModel.user.email = value;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Role',
                          hintText: 'Masukkan role',
                        ),
                        controller: TextEditingController(text: userViewModel.user.role),
                        onChanged: (value) {
                          userViewModel.user.role = value;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Alamat',
                          hintText: 'Masukkan alamat',
                        ),
                        controller: TextEditingController(text: userViewModel.user.alamat),
                        onChanged: (value) {
                          userViewModel.user.alamat = value;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'No. Handphone',
                          hintText: 'Masukkan nomor handphone',
                        ),
                        controller: TextEditingController(text: userViewModel.user.noTelp),
                        onChanged: (value) {
                          userViewModel.user.noTelp = value;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Masukkan password',
                        ),
                        controller: TextEditingController(text: userViewModel.user.password),
                        onChanged: (value) {
                          userViewModel.user.password = value;
                        },
                      ),
                    ],
                  ),
                 ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
