import '../../../../constants/data_state.dart';
import '../entities/live_string_entity.dart';
import '../entities/string_entity.dart';

abstract class DashboardRepository {
  Future<DataState<List<LiveStringEntity>>> getLiveStringData(int projectId);
}

