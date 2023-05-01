import 'package:dio/dio.dart';

class UserService {
  Dio _dio = Dio();
  String baseUrl = 'http://192.168.2.106:4000/api/user/';

  Future<Response> getUser(int userId) async {
    return await _dio.get('${baseUrl}detail/$userId');
  }
}