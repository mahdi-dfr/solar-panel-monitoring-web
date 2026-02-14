import 'package:get/get.dart';
import 'package:solar_web/features/dashboard/domain/entities/panels_entity.dart';
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';
import 'package:solar_web/features/dashboard/domain/usecase/panel_usecase.dart';
import 'package:solar_web/features/dashboard/domain/usecase/project_usecase.dart';

import '../../../../constants/data_state.dart';

class ProjectsController extends GetxController {
  final ProjectUseCase _projectUseCase;


  ProjectsController(this._projectUseCase,);

  var isLoading = false.obs;


  @override
  void onInit() {
    getProjects();
    super.onInit();
  }

  final RxList<ProjectEntity> projects = RxList();


  Future<DataState<String>> getProjects() async {
    isLoading.value = true;
    final result = await _projectUseCase.call(null);
    projects.value = result.data!.results!;
    isLoading.value = false;

    return DataSuccess('');
  }


}
