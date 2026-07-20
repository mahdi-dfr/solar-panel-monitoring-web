import 'package:dio/dio.dart';

import '../../../../constants/aip_interseptor.dart';
import '../../../../constants/url_constants.dart';

class DashboardApiService {

  final Dio _dio = Dio();

  Future<dynamic> getLiveData(int projectId) async {
    print('1111111');

    _dio.interceptors.add(ApiInterceptor());

    try {

      final response = await _dio.get(
        "${UrlConstant.baseUrl}project/projects/$projectId/live-data/",
      );

      print('222222222');
      print(response);
      return response;

    } catch(e) {
      print(e);

      return e;

    }
  }
}