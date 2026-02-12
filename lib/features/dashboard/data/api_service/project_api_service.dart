import 'package:dio/dio.dart';

import '../../../../constants/aip_interseptor.dart';
import '../../../../constants/url_constants.dart';

class ProjectApiService {
  final Dio _dio = Dio();

  Future<dynamic> getProjects() async {
    _dio.interceptors.add(ApiInterceptor());
    try {
      final response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.project,
      );
      print('1111');
      print(response);
      return response;
    } catch(e){
      print('2222');
      print(e);
      return e;
    }
  }

  Future<dynamic> getWeather() async {
    _dio.interceptors.add(ApiInterceptor());
    try {
      final response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.project,
      );
      print(response);
      return response;
    } catch(e){
      return e;
    }
  }
}

