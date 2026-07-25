import 'package:dio/dio.dart';

import '../../../../constants/aip_interseptor.dart';
import '../../../../constants/url_constants.dart';

class DashboardApiService {

  final Dio _dio = Dio();

  Future<dynamic> getLiveData(int projectId) async {
    print('7777777777');

    _dio.interceptors.add(ApiInterceptor());

    try {

      final response = await _dio.get(
        "${UrlConstant.baseUrl}api/project/projects/$projectId/live-data/",
      );

      print('javab');
      print(response);
      return response;

    } catch(e) {
      print('errror');
      print(e.toString());

      return e;

    }
  }
}