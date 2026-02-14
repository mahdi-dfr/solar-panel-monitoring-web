import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/features/dashboard/domain/entities/panels_entity.dart';
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';
import 'package:solar_web/features/dashboard/domain/usecase/panel_usecase.dart';
import 'package:solar_web/features/dashboard/domain/usecase/project_usecase.dart';

import '../../../../constants/data_state.dart';
import '../screens/dashboard_view.dart';

class ProjectsController extends GetxController {
  final ProjectUseCase _projectUseCase;
  final PanelUseCase _panelUseCase;

  ProjectsController(this._projectUseCase, this._panelUseCase);

  var isLoading = false.obs;
  int projectId = -1;

  @override
  void onInit() {
    getProjects();
    super.onInit();
  }

  final RxList<ProjectEntity> projects = RxList();
  final RxList<PanelEntity> panels = RxList();



  Future<DataState<String>> getProjects() async {
    isLoading.value = true;
    final result = await _projectUseCase.call(null);
    projects.value = result.data!.results!;
    isLoading.value = false;

    return DataSuccess('');
  }



  Future<DataState<String>> getPanels(int projectId) async {
    isLoading.value = true;
    final result = await _panelUseCase.call(projectId);
    panels.value = result.data!.results;
    isLoading.value = false;

    print('3333');
    print(projectId);
    print(panels.value);

    return DataSuccess('');
  }
}



