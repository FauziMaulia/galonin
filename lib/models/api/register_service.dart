import 'package:dio/dio.dart';

import '../register.dart';

class RegisterService {
  final String _baseUrl = "http://192.168.2.106:3000/api";
  Dio _dio = Dio();

  Future<Register> registerUser(String email, String nama, String role, String alamat, String password) async {
    try {
      Response response = await _dio.post("$_baseUrl/register", data: {
        "email": email,
        "nama": nama,
        "role": role,
        "alamat": alamat,
        "password": password,
      });
      return Register.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
      throw Exception('Failed to register Register');
    }
  }
}
