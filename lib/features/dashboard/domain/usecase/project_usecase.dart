import 'package:solar_web/constants/usecase.dart';

import '../../../../constants/data_state.dart';
import '../entities/project_entity.dart';
import '../repository/auth_repository.dart';

class ProjectUseCase extends UseCase<ProjectListEntity, void> {
  final ProjectRepository _repository;

  ProjectUseCase(this._repository);

  @override
  Future<DataState<ProjectListEntity>> call(void params) {
    return _repository.getProjects();
  }
}
