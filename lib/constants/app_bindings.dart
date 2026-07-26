import 'package:get/get.dart';
import 'package:solar_web/features/authentication/data/api_service/auth_api_service.dart';
import 'package:solar_web/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:solar_web/features/dashboard/data/api_service/project_api_service.dart';
import 'package:solar_web/features/dashboard/domain/repository/projects_repository.dart';
import 'package:solar_web/features/dashboard/domain/usecase/dashboard_usecase.dart';
import 'package:solar_web/features/dashboard/domain/usecase/panel_usecase.dart';
import 'package:solar_web/features/dashboard/domain/usecase/weather_usecase.dart';

import '../features/authentication/domain/repository/auth_repository.dart';
import '../features/authentication/domain/usecase/login_usecase.dart';
import '../features/authentication/domain/usecase/user_info_usecase.dart';
import '../features/authentication/presentation/controller/login_controller.dart';
import '../features/dashboard/data/api_service/dashboard_api_service.dart';
import '../features/dashboard/data/repository/dashboard_repository_impl.dart';
import '../features/dashboard/data/repository/project_repository_impl.dart';
import '../features/dashboard/domain/repository/dashboard_repository.dart';
import '../features/dashboard/domain/usecase/project_usecase.dart';
import '../features/dashboard/presentation/controller/dashboard_controller.dart';
import '../features/dashboard/presentation/controller/project_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// api service
    Get.put<AuthApiService>(AuthApiService());
    Get.put<ProjectApiService>(ProjectApiService());
    Get.put<DashboardApiService>(DashboardApiService());

    /// repository
    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find<AuthApiService>()));
    Get.put<ProjectRepository>(ProjectRepositoryImpl(Get.find<ProjectApiService>()));
    Get.put<DashboardRepository>(DashboardRepositoryImpl(Get.find<DashboardApiService>()));

    /// use case
    Get.put(LoginUseCase(Get.find<AuthRepository>()));
    Get.put(ProjectUseCase(Get.find<ProjectRepository>()));
    Get.put(WeatherUseCase(Get.find<ProjectRepository>()));
    Get.put(DashboardUseCase(Get.find<DashboardRepository>()));
    Get.put(UserInfoUseCase(Get.find<AuthRepository>()));
    Get.put(GetDashboardChartUseCase(Get.find<DashboardRepository>()));

    /// controllers
    Get.lazyPut(
      () => DashboardController(
        Get.find<WeatherUseCase>(),
        Get.find<DashboardUseCase>(),
        Get.find<GetDashboardChartUseCase>(),
      ),
    );
    Get.put(LoginController(Get.find<LoginUseCase>(), Get.find<UserInfoUseCase>()));
    // Get.put(ProjectsController(Get.find<ProjectUseCase>()));

    Get.lazyPut(() => ProjectsController(Get.find<ProjectUseCase>(),));
  }
}
