import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService with ChangeNotifier{
  static const String apiUrl = 'http://192.168.2.106:3000/api/login';
  
  Future<int?> login(LoginModel loginModel) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
        apiUrl,
        data:loginModel.toJson()
      );
      print('post');
      print(response.data['data']['userId']);

      if (response.data != null) {
        return  response.data['data']['userId'];
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
      return null;
    }
  } 
}
