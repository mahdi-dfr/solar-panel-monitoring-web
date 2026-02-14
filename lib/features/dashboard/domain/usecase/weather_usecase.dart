import 'package:solar_web/constants/usecase.dart';

import '../../../../constants/data_state.dart';
import '../entities/weather_entity.dart';
import '../repository/projects_repository.dart';

class WeatherUseCase extends UseCase<WeatherEntity, int> {
  final ProjectRepository _repository;

  WeatherUseCase(this._repository);

  @override
  Future<DataState<WeatherEntity>> call(int projectId) {
    return _repository.getWeather(projectId);
  }
}
