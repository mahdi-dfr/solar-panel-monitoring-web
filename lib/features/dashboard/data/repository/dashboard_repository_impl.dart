import 'package:dio/dio.dart';
import 'package:solar_web/features/dashboard/data/model/live_string_model.dart';

import '../../../../constants/data_state.dart';
import '../../domain/entities/live_string_entity.dart';
import '../../domain/entities/string_entity.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../api_service/dashboard_api_service.dart';
import '../model/string_model.dart';

class DashboardRepositoryImpl extends DashboardRepository {

  final DashboardApiService _apiService;

  DashboardRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<LiveStringEntity>>> getLiveStringData(
      int projectId,
      ) async {

    try {

      final response =
      await _apiService.getLiveData(projectId);

      if(response is! DioException){

        List<LiveStringEntity> result = [];

        final boards = response.data['boards'];

        for(final board in boards){

          final strings = board['strings'];

          for(final string in strings){

            result.add(
              LiveStringModel.fromJson(string),
            );
          }
        }

        return DataSuccess(result);
      }

      return DataFailed(
          'خطای دریافت اطلاعات'
      );

    } catch(e){

      return DataFailed(
          'خطای دریافت اطلاعات'
      );

    }
  }
}