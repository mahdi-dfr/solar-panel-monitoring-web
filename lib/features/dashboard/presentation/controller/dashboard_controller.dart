import 'package:get/get.dart';

import '../../../../constants/data_state.dart';
import '../../data/model/PanelUiModel.dart';
import '../../data/model/dashboard_model.dart';
import '../../domain/entities/panels_entity.dart';
import '../../domain/usecase/panel_usecase.dart';

class DashboardController extends GetxController {

  final PanelUseCase _panelUseCase;

  DashboardController(this._panelUseCase);

  final selectedPanelId = 1.obs;

  final isHover = false.obs;
  final temperature = 32.5.obs;
  final humidity = 41.obs;

  int projectId = -1;

  var isLoading = false.obs;

  final RxList<PanelUiModel> panels = <PanelUiModel>[].obs;


  // final panels = <PanelModel>[
  //   PanelModel(1, 0.23, 24, 1.04, false),
  //   PanelModel(2, 0.52, 24, 2.36, false),
  //   PanelModel(3, 0.31, 0, 0, false),
  //   PanelModel(4, 0.06, 24, 0.28, false),
  //   PanelModel(5, 0.79, 24, 3.57, false),
  //   PanelModel(6, 0.53, 24, 2.39, false),
  //   PanelModel(7, 0.11, 24, 0.50, false),
  //   PanelModel(8, 0.11, 24, 0.49, false),
  // ].obs;

  PanelUiModel get selectedPanel =>
      panels.firstWhere((e) => e.id == selectedPanelId.value);



  void selectPanel(int id) {
    selectedPanelId.value = id;
  }

  void updateWeather(double temp, int hum) {
    temperature.value = temp;
    humidity.value = hum;
  }

  Future<void> getPanels(int projectId) async {
    isLoading.value = true;

    final result = await _panelUseCase.call(projectId);

    if (result is DataSuccess) {
      panels.value = result.data!.results.map((e) {
        return PanelUiModel(
          id: e.id,
          name: e.panelName,
          boardId: e.boardId,
          current: 1.04,
          voltage: 24,
          isOn: true,
          radiance: 0.23
        );
      }).toList();
    }

    isLoading.value = false;
  }

}
