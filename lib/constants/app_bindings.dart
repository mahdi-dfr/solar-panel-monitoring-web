import 'package:get/get.dart';
import 'package:solar_web/core/contrroller/dashboard_controller.dart';
import 'package:solar_web/core/contrroller/login_controller.dart';

import '../core/view/screens/login_screen.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(LoginController());
  }

}