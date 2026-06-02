import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/dashboard/domain/entities/string_entity.dart';
import 'package:solar_web/features/dashboard/domain/repository/dashboard_repository.dart';

import '../../../../constants/usecase.dart';

class DashboardUseCase extends UseCase<List<StringLiveEntity>, int>{
  final DashboardRepository _repository;
  DashboardUseCase(this._repository);

  @override
  Future<DataState<List<StringLiveEntity>>> call(int params) {
    return _repository.getLiveData(params);
  }



}