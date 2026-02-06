import 'package:get/get.dart';
import 'package:solar_web/features/authentication/data/api_service/auth_api_service.dart';
import 'package:solar_web/features/authentication/usecase/repository/auth_repository.dart';
import 'package:solar_web/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:solar_web/features/authentication/usecase/usecase/login_usecase.dart';

import '../features/authentication/view/controller/login_controller.dart';
import '../features/dashboard/controller/dashboard_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// api service
    Get.put<AuthApiService>(AuthApiService());

    /// repository
    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find<AuthApiService>()));

    /// use case
    Get.put(LoginUseCase(Get.find<AuthRepository>()));

    /// controllers
    Get.put(DashboardController());
    Get.put(LoginController(Get.find<LoginUseCase>()));
  }
}
