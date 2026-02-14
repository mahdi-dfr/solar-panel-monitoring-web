import 'package:solar_web/features/dashboard/domain/entities/panels_entity.dart';

import '../../../../constants/data_state.dart';
import '../../../../constants/usecase.dart';
import '../repository/projects_repository.dart';

class PanelUseCase extends UseCase<PanelListEntity, int> {
  final ProjectRepository _repository;

  PanelUseCase(this._repository);

  @override
  Future<DataState<PanelListEntity>> call(int projectId) {
    return _repository.getPanels(projectId);
  }
}