import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/constants/constant.dart';

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

  Timer? _timer;

  var isLoading = false.obs;
  var isWeatherLoading = false.obs;

  final RxList<PanelUiModel> panels = <PanelUiModel>[].obs;


  PanelUiModel get selectedPanel =>
      panels.firstWhere((e) => e.id == selectedPanelId.value);

  @override
  void onInit() {

    // getPanels(GetStorage().read(AppConstants.projectID)).then((value){
    //   loadWeather(GetStorage().read(AppConstants.projectID));
    // });
    // _timer = Timer.periodic(const Duration(hours: 3), (timer) {
    //   loadWeather(GetStorage().read(AppConstants.projectID));
    // });
    super.onInit();
  }



  void selectPanel(int id) {
    selectedPanelId.value = id;
  }

  void updateWeather(double temp, int hum) {
    temperature.value = temp;
    humidity.value = hum;
  }

  saveProjectId(int projectID){
    GetStorage().write(AppConstants.projectID, projectID);
  }

  Future<void> getPanels(int projectId) async {
    print('1111111111111223');
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

    print(panels.value);

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
