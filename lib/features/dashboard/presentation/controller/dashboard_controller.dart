import 'dart:async';

import 'package:get/get.dart';

import '../../../../constants/data_state.dart';
import '../../data/model/PanelUiModel.dart';
import '../../data/model/dashboard_model.dart';
import '../../domain/entities/panels_entity.dart';
import '../../domain/usecase/panel_usecase.dart';
import '../../domain/usecase/weather_usecase.dart';

class DashboardController extends GetxController {

  final PanelUseCase _panelUseCase;
  final WeatherUseCase _weatherUseCase;

  DashboardController(this._panelUseCase, this._weatherUseCase);

  final selectedPanelId = 1.obs;

  final isHover = false.obs;

  final city = ''.obs;
  final temperature = 0.0.obs;
  final humidity = 0.obs;
  final condition = ''.obs;
  final windSpeed = 0.0.obs;

  int projectId = -1;

  Timer? _timer;

  var isLoading = false.obs;
  var isWeatherLoading = false.obs;

  final RxList<PanelUiModel> panels = <PanelUiModel>[].obs;


  PanelUiModel get selectedPanel =>
      panels.firstWhere((e) => e.id == selectedPanelId.value);

  @override
  void onInit() {

    _timer = Timer.periodic(const Duration(hours: 3), (timer) {
      loadWeather(projectId);
    });
    super.onInit();
  }



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


  Future<void> loadWeather(int projectId) async {

    isWeatherLoading.value = true;

    final result = await _weatherUseCase.call(projectId);

    if (result is DataSuccess) {

      final data = result.data!;

      city.value = data.city;
      temperature.value = data.tempC;
      humidity.value = data.humidity;
      condition.value = data.condition;
      windSpeed.value = data.windKph;
    }

    isWeatherLoading.value = false;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

}
