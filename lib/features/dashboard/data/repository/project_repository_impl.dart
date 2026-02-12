import 'package:dio/dio.dart';
import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/authentication/data/model/auth_model.dart';
import 'package:solar_web/features/dashboard/data/model/project_model.dart';
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';

import '../../domain/repository/auth_repository.dart';
import '../api_service/project_api_service.dart';

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
          print(entity);
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
}
