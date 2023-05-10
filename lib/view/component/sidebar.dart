import 'package:flutter/material.dart';
import 'package:miniproject/viewmodel/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../viewmodel/provider/login_provider.dart';

// ignore: must_be_immutable
class Sidebar extends StatelessWidget {
  UserViewModel userViewModel = UserViewModel();
  Sidebar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     userViewModel.getUserDetail();
    return  Drawer(
          child: ListView(
            children: [ Consumer<UserViewModel>(
                builder: (_, userViewModel, __) {
                      userViewModel.getUserDetail();
                  // ignore: unrelated_type_equality_checks
                  if(userViewModel.user.nama.isNotEmpty){
                    return UserAccountsDrawerHeader(
                            accountName: Text(userViewModel.user.nama),
                            accountEmail: Text(userViewModel.user.email),
                            currentAccountPicture: CircleAvatar(
                              backgroundImage: NetworkImage(userViewModel.user.imageUrl),
                            ),
                        );
                    }else{
                      userViewModel.getUserDetail();
                      return const UserAccountsDrawerHeader(
                            accountName: CircularProgressIndicator(),
                            accountEmail: CircularProgressIndicator(),
                            currentAccountPicture: CircleAvatar(
                              
                            ),
                        );
                    }
                },
            ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');

                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<LoginProvider>(context, listen: false).logout();
                  userViewModel.deleteUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
              ),
            ],
          ),
        );
      }
  }


