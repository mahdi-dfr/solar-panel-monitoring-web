import 'package:get/get.dart';
import 'package:solar_web/core/contrroller/dashboard_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(DashboardController());
  }

}