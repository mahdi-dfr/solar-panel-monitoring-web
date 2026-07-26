import '../../../../constants/data_state.dart';
import '../entities/chart_entity.dart';
import '../entities/live_string_entity.dart';

abstract class DashboardRepository {
  Future<DataState<List<LiveStringEntity>>> getLiveStringData(int projectId);

  Future<DataState<List<DashboardChartEntity>>> getDashboardChartData(int projectId, String period,);
}

