import '../../../../constants/data_state.dart';
import '../entities/string_entity.dart';

abstract class DashboardRepository {
  Future<DataState<List<StringLiveEntity>>> getLiveData(int projectId);
}
