import 'package:dio/dio.dart';
import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/authentication/data/model/auth_model.dart';
import 'package:solar_web/features/authentication/usecase/repository/auth_repository.dart';

import '../../usecase/entities/auth_entity.dart';
import '../api_service/auth_api_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<DataState<AuthEntity>> loginUser(String username, String password) async {
    try {
      final response = await _apiService.loginUser({
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        AuthEntity entity = AuthModel.fromJson(response.data);
        return DataSuccess<AuthEntity>(entity);
      }

      return DataFailed<AuthEntity>(ServerFailure() as String);
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        return DataFailed(e.response!.data['detail']);
      }
      return DataFailed('خطایی رخ داده است!');
    }
  }
}
