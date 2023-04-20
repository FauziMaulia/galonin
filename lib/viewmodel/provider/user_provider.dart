import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/api/user_service.dart';
import '../../models/user.dart';

class UserViewModel with ChangeNotifier {
  User _user = User();
  String _error = '';
  bool _isLoading = false;
  UserService _userService = UserService();

  User get user => _user;
  String get error => _error;
  bool get isLoading => _isLoading;

  Future<void> getUserDetail() async {
    try {
      // Set isLoading menjadi true saat melakukan request
      _isLoading = true;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('userId') ?? 0;
      // Mengirim request GET ke API menggunakan UserService
      Response response = await _userService.getUser(userId);

      if (response.data['data'] != null) {
        // Jika response berhasil, mengambil data pengguna dari response
        Map<String, dynamic> userData = response.data['data'];

        // Menggunakan data pengguna
        _user = User(
          userId: userData['user_id'],
          email: userData['email'],
          nama: userData['nama'],
          role: userData['role'],
          alamat: userData['alamat'],
          imageUrl: userData['imageUrl']
        );

        // Mengatur error menjadi kosong
        _error = '';
      } else {
        // Jika response tidak berhasil, mengatur error sesuai response
        _error = response.data['message'];
      }
    } catch (error) {
      // Jika terjadi error saat melakukan request, mengatur error
      _error = 'Gagal mengambil data pengguna. $error';
    } finally {
      // Set isLoading menjadi false setelah request selesai
      _isLoading = false;
      notifyListeners();
    }
  }
}