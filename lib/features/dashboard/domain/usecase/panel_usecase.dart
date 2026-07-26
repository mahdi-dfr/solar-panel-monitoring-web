import '../../../../constants/data_state.dart' show DataState;
import '../../../../constants/usecase.dart';
import '../entities/chart_entity.dart';
import '../repository/dashboard_repository.dart';

class GetDashboardChartUseCase
    extends UseCase<
        List<DashboardChartEntity>,
        DashboardChartParams
    > {

  final DashboardRepository _repository;

  GetDashboardChartUseCase(
      this._repository,
      );

  @override
  Future<DataState<List<DashboardChartEntity>>>
  call(
      DashboardChartParams params,
      ) {

    return _repository.getDashboardChartData(
      params.projectId,
      params.period,
    );
  }
}


class DashboardChartParams {

  final int projectId;
  final String period;

  DashboardChartParams({
    required this.projectId,
    required this.period,
  });
}

