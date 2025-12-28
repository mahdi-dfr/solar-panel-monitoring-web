import 'package:get/get.dart';
import 'package:solar_web/core/model/dashboard_model.dart';

class DashboardController extends GetxController {
  final selectedPanelId = 1.obs;

  final panels = <PanelModel>[
    PanelModel(1, 0.23, 24, 1.04),
    PanelModel(2, 0.52, 24, 2.36),
    PanelModel(3, 0.31, 0, 0),
    PanelModel(4, 0.06, 24, 0.28),
    PanelModel(5, 0.79, 24, 3.57),
    PanelModel(6, 0.53, 24, 2.39),
    PanelModel(7, 0.11, 24, 0.50),
    PanelModel(8, 0.11, 24, 0.49),
  ].obs;

  PanelModel get selectedPanel =>
      panels.firstWhere((e) => e.id == selectedPanelId.value);



  void selectPanel(int id) {
    selectedPanelId.value = id;



  }
}
