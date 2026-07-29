import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';
import 'package:solar_web/features/dashboard/domain/usecase/project_usecase.dart';

import '../../../../constants/constant.dart';
import '../../../../constants/data_state.dart';

class ProjectsController extends GetxController {
  final ProjectUseCase _projectUseCase;

  ProjectsController(this._projectUseCase);

  var isLoading = false.obs;

  @override
  void onInit() {
    getProjects();
    super.onInit();
  }

  final RxList<ProjectEntity> projects = RxList();

  Future<DataState<String>> getProjects() async {
    print('11111111111111110');
    isLoading.value = true;
    final result = await _projectUseCase.call(null);
    projects.value = result.data!.results!;
    isLoading.value = false;
    print('000000000000000000001');
    return DataSuccess('');
  }


  saveProjectId(int projectID) {
    GetStorage().write(AppConstants.projectID, projectID);
  }
}
