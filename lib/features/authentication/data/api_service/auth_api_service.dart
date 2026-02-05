import 'package:dio/dio.dart';

import '../../../../constants/url_constants.dart';

class AuthApiService{
  final Dio _dio = Dio();

  Future<dynamic> loginUser(Map<String, dynamic> data) async {
    // _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.login,
        data: data,
        options: Options(responseType: ResponseType.json, method: 'POST'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }
}