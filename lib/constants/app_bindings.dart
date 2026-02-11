import 'package:get/get.dart';
import 'package:solar_web/features/authentication/data/api_service/auth_api_service.dart';
import 'package:solar_web/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:solar_web/features/dashboard/data/api_service/project_api_service.dart';
import 'package:solar_web/features/dashboard/domain/repository/auth_repository.dart';

import '../features/authentication/domain/repository/auth_repository.dart';
import '../features/authentication/domain/usecase/login_usecase.dart';
import '../features/authentication/view/controller/login_controller.dart';
import '../features/dashboard/data/repository/project_repository_impl.dart';
import '../features/dashboard/domain/usecase/project_usecase.dart';
import '../features/dashboard/presentation/controller/dashboard_controller.dart';
import '../features/dashboard/presentation/controller/project_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// api service
    Get.put<AuthApiService>(AuthApiService());
    Get.put<ProjectApiService>(ProjectApiService());

    /// repository
    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find<AuthApiService>()));
    Get.put<ProjectRepository>(ProjectRepositoryImpl(Get.find<ProjectApiService>()));

    /// use case
    Get.put(LoginUseCase(Get.find<AuthRepository>()));
    Get.put(ProjectUseCase(Get.find<ProjectRepository>()));

    /// controllers
    Get.put(DashboardController());
    Get.put(LoginController(Get.find<LoginUseCase>()));
    Get.put(ProjectsController(Get.find<ProjectUseCase>()));
  }
}
