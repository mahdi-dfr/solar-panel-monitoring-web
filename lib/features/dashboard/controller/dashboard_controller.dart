import 'package:get/get.dart';

import '../data/mode/dashboard_model.dart';

class DashboardController extends GetxController {
  final selectedPanelId = 1.obs;

  final isHover = false.obs;
  final temperature = 32.5.obs;
  final humidity = 41.obs;

  final panels = <PanelModel>[
    PanelModel(1, 0.23, 24, 1.04, false),
    PanelModel(2, 0.52, 24, 2.36, false),
    PanelModel(3, 0.31, 0, 0, false),
    PanelModel(4, 0.06, 24, 0.28, false),
    PanelModel(5, 0.79, 24, 3.57, false),
    PanelModel(6, 0.53, 24, 2.39, false),
    PanelModel(7, 0.11, 24, 0.50, false),
    PanelModel(8, 0.11, 24, 0.49, false),
  ].obs;

  PanelModel get selectedPanel =>
      panels.firstWhere((e) => e.id == selectedPanelId.value);



  void selectPanel(int id) {
    selectedPanelId.value = id;
  }

  void updateWeather(double temp, int hum) {
    temperature.value = temp;
    humidity.value = hum;
  }
}
