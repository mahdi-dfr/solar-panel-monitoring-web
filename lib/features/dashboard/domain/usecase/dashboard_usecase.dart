import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/dashboard/domain/entities/string_entity.dart';
import 'package:solar_web/features/dashboard/domain/repository/dashboard_repository.dart';

import '../../../../constants/usecase.dart';
import '../entities/live_string_entity.dart';

class DashboardUseCase extends UseCase<List<LiveStringEntity>, int>{
  final DashboardRepository _repository;
  DashboardUseCase(this._repository);

  @override
  Future<DataState<List<LiveStringEntity>>> call(int params) {
    return _repository.getLiveStringData(params);
  }



}