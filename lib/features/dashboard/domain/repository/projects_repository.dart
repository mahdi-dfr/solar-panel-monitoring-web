
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';

import '../../../../constants/data_state.dart';
import '../entities/panels_entity.dart';
import '../entities/weather_entity.dart';

abstract class ProjectRepository{

  Future<DataState<ProjectListEntity>> getProjects();

  Future<DataState<PanelListEntity>> getPanels(int projectId);

  Future<DataState<WeatherEntity>> getWeather(int projectId);


}