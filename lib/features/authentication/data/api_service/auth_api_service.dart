import 'package:dio/dio.dart';

import '../../../../constants/aip_interseptor.dart';
import '../../../../constants/url_constants.dart';

class AuthApiService {
  final Dio _dio = Dio();

  Future<dynamic> loginUser(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.login,
        data: data,
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }


  Future<dynamic> getUserInfo() async {
    _dio.interceptors.add(ApiInterceptor());
    try {
      final response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.user,
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }
}

