import 'package:dio/dio.dart';

import '../../../../constants/url_constants.dart';

class AuthApiService {
  final Dio _dio = Dio();

  Future<Response> loginUser(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.login,
        data: data,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}

