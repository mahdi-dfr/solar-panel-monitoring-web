import 'package:get/get.dart';

import '../features/authentication/controller/login_controller.dart';
import '../features/dashboard/controller/dashboard_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(LoginController());
  }

}