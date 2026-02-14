import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/constants/constant.dart';
import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/authentication/data/model/auth_model.dart';
import 'package:solar_web/features/dashboard/data/model/project_model.dart';
import 'package:solar_web/features/dashboard/domain/entities/panels_entity.dart';
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/repository/projects_repository.dart';
import '../api_service/project_api_service.dart';
import '../model/panel_model.dart';
import '../model/weather_model.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final ProjectApiService _apiService;

  ProjectRepositoryImpl(this._apiService);


  @override
  Future<DataState<ProjectListEntity>> getProjects() async {

    try {
      final response = await _apiService.getProjects();

      if(response is! DioException){
        if (response.statusCode == 200) {
          ProjectListEntity entity = ProjectListModel.fromJson(response.data);
          return DataSuccess<ProjectListEntity>(entity);
        }
      }

      return DataFailed<ProjectListEntity>('خطای سرور رخ داده است');
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        return DataFailed(e.response!.data['detail']);
      }
      return DataFailed('خطایی رخ داده است!');
    }

  }

  @override
  Future<DataState<PanelListEntity>> getPanels(int projectId) async {

    try {
      final response = await _apiService.getPanels(projectId);

      if (response is! DioException) {
        if (response.statusCode == 200) {
          PanelListEntity entity =
          PanelListModel.fromJson(response.data);

          print('2222');
          print(response);
          return DataSuccess<PanelListEntity>(entity);
        }
      }

      return DataFailed<PanelListEntity>('خطای سرور رخ داده است');
    } on DioException catch (e) {

      if (e.response != null && e.response!.statusCode == 401) {
        return DataFailed(e.response!.data['detail']);
      }

      return DataFailed('خطایی رخ داده است!');
    }
  }

  @override
  Future<DataState<WeatherEntity>> getWeather(int projectId) async {

    try {
      final response = await _apiService.getWeather(projectId);

      if (response is! DioException) {
        if (response.statusCode == 200) {

          WeatherEntity entity =
          WeatherModel.fromJson(response.data);

          return DataSuccess<WeatherEntity>(entity);
        }
      }

      return DataFailed<WeatherEntity>('خطای سرور رخ داده است');

    } on DioException catch (e) {

      if (e.response != null && e.response!.statusCode == 401) {
        return DataFailed(e.response!.data['detail']);
      }

      return DataFailed('خطایی رخ داده است!');
    }
  }
}
