import 'package:dio/dio.dart';

import '../../../../constants/url_constants.dart';

class ProjectApiService {
  final Dio _dio = Dio();

  Future<Response> getProjects() async {
    try {
      final response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.project,
      );
      print(response);
      return response;
    } catch(e){
      print(e);
      rethrow;
    }
  }
}

