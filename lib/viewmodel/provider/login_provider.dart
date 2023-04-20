import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/api/login_services.dart';
import '../../models/login.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  final LoginService _loginService = LoginService(); // Instantiate LoginService

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int? user;
  // Fungsi untuk melakukan login
  Future<int?> login(LoginModel loginModel) async {

    try {
      // Set status loading menjadi true
      _isLoading = true;
      notifyListeners();
      // Panggil fungsi login dari LoginService dan tunggu selama 2 detik
      user = await  _loginService.login(loginModel);

      return user;
    } catch (e) {
      // Set error message jika terjadi error saat login
      _errorMessage = 'Login failed. Please try again.';
      notifyListeners();
    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId'); // Hapus data userId dari SharedPreferences
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}