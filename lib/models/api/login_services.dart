import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService with ChangeNotifier{
  static const String apiUrl = 'https://galonin.temanhorizon.com/api/login';
  
  Future<int?> login(LoginModel loginModel) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
        apiUrl,
        data:loginModel.toJson()
      );

      if (response.data != null) {
        return  response.data['data']['userId'];
      } else {
        return response.statusCode;
      }
    } catch (e) {

      return null;
    }
  } 
}
