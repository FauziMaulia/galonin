import 'package:flutter/material.dart';
import 'package:miniproject/viewmodel/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/provider/login_provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        userViewModel.getUserDetail();
        return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(userViewModel.user.nama),
                accountEmail: Text(userViewModel.user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(userViewModel.user.imageUrl),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<LoginProvider>(context, listen: false).logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
