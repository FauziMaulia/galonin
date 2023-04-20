import 'package:flutter/material.dart';
import '../../models/api/register_service.dart';
import '../../view/component/snackbar.dart';

class RegisterProvider with ChangeNotifier {
  final RegisterService _registerService = RegisterService();
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> registerUser(String email, String nama, String role, String alamat, String password, BuildContext context) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      final response = await _registerService.registerUser(email, nama, role, alamat, password);

      if (response.status == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/login');
      } else {
        _errorMessage = response.message;
        notifyListeners();
        
      }

      _isLoading = false;
      notifyListeners();
      return showSnackbar(context, '${response.message}');

    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
