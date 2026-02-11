import 'package:get/get.dart';
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

  final projects = <ProjectModel>[
    ProjectModel(name: 'Solar Plant - Tehran', address: 'Tehran, District 22'),
    ProjectModel(name: 'Solar Farm - Isfahan', address: 'Isfahan Industrial Zone'),
    ProjectModel(name: 'Solar Panels - Shiraz', address: 'Shiraz, Sadra City'),
    ProjectModel(name: 'Factory Roof Project', address: 'Karaj Industrial Area'),
  ].obs;

  Future<DataState<String>> getProjects() async {
    isLoading.value = true;

    final result = await _useCase.call(null);
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
