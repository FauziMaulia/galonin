import 'package:dio/dio.dart';

class UserService {
  Dio _dio = Dio();
  String baseUrl = 'https://galonin.temanhorizon.com/api/user/';

  Future<Response> getUser(int userId) async {
    return await _dio.get('${baseUrl}detail/$userId');
  }
}