import 'package:dio/dio.dart';

import '../../../../constants/aip_interseptor.dart';
import '../../../../constants/url_constants.dart';

class DashboardApiService {

  final Dio _dio = Dio();

  Future<dynamic> getLiveData(int projectId) async {

    _dio.interceptors.add(ApiInterceptor());

    try {

      final response = await _dio.get(
        "${UrlConstant.baseUrl}/api/projects/$projectId/live-data/",
      );

      return response;

    } catch(e) {

      return e;

    }
  }
}