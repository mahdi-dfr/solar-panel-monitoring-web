import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';
import 'package:solar_web/features/dashboard/domain/usecase/project_usecase.dart';

import '../../../../constants/data_state.dart';
import '../screens/dashboard_view.dart';

class ProjectsController extends GetxController {
  final ProjectUseCase _useCase;

  ProjectsController(this._useCase);

  var isLoading = false.obs;

  @override
  void onInit() {
    getProjects();
    super.onInit();
  }

  final RxList<ProjectEntity> projects = RxList();

  Future<DataState<String>> getProjects() async {
    isLoading.value = true;

    final result = await _useCase.call(null);

    print(result.data!);

    projects.value = result.data!.results!;
    print(projects.value);

    print(result);

    isLoading.value = false;

    return DataSuccess('');
  }
}

class ProjectModel {
  final String name;
  final String address;

  ProjectModel({required this.name, required this.address});
}
