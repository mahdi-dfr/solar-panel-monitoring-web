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
      return response;
    } catch(e){
      return e;
    }
  }


  Future<dynamic> getPanels(int projectId) async {
    _dio.interceptors.add(ApiInterceptor());
    try {
      final response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.panel,
        queryParameters: {
          "project_id": projectId,
        },
      );
      return response;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getWeather(int projectId) async {
    _dio.interceptors.add(ApiInterceptor());
    try {
      final response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.weather,
        queryParameters: {
          "project_id": projectId,
        },
      );
      return response;
    } catch (e) {
      return e;
    }
  }


}

