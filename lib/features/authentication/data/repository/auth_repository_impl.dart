import 'package:dio/dio.dart';
import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/authentication/data/mode/auth_model.dart';
import 'package:solar_web/features/authentication/data/repository/auth_repository.dart';

import '../api_service/auth_api_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<DataState<AuthModel>> loginUser(String username, String password) async {
    var response = await _apiService.loginUser({'username': username, 'password': password});
    if (response is! DioException) {
      if (response.statusCode == 200) {
        AuthModel entity = AuthModel.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.message);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }
}
