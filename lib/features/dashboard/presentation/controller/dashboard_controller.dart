import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/constants/constant.dart';

import '../../../../constants/data_state.dart';
import '../../data/model/PanelUiModel.dart';
import '../../domain/entities/chart_entity.dart';
import '../../domain/entities/live_string_entity.dart';
import '../../domain/usecase/dashboard_usecase.dart';
import '../../domain/usecase/panel_usecase.dart';
import '../../domain/usecase/weather_usecase.dart';

class DashboardController extends GetxController {
  final GetDashboardChartUseCase _chartUseCase;
  final WeatherUseCase _weatherUseCase;
  final DashboardUseCase _useCase;

  DashboardController(
    this._weatherUseCase,
    this._useCase,
    GetDashboardChartUseCase chartUseCase,
  ) : _chartUseCase = chartUseCase;



  final RxList<LiveStringEntity> strings = <LiveStringEntity>[].obs;
  final isLoading = false.obs;
  final selectedPanelId = 1.obs;
  final isHover = false.obs;
  final city = ''.obs;
  final temperature = 0.0.obs;
  final humidity = 0.obs;
  final condition = ''.obs;
  final windSpeed = 0.0.obs;
  Timer? _timer;
  var isWeatherLoading = false.obs;
  final RxList<PanelUiModel> panels = <PanelUiModel>[].obs;
  final RxList<DashboardChartEntity>
  chartData = <DashboardChartEntity>[].obs;
  final selectedChartPeriod = AppConstants.chartPeriod.obs;



  @override
  void onInit() {

    loadLiveData();

    loadDashboardChartData();

    _timer = Timer.periodic(
      Duration(
        minutes: AppConstants.requestLiveDataTimer,
      ),
          (_) {

        loadLiveData();

        loadDashboardChartData(
          showLoading: false,
        );
      },
    );

    super.onInit();
  }


  @override
  void onClose() {
    _timer?.cancel();

    super.onClose();
  }

  Future<void> loadLiveData() async {
    print('adadadadsssdds');
    print(GetStorage().read(AppConstants.projectID));
    print(GetStorage().read(AppConstants.projectID).runtimeType);
    final result = await _useCase.call(
      GetStorage().read(AppConstants.projectID),
    );

    if (result is DataSuccess) {
      strings.assignAll(result.data!);
    }
  }

  void updateWeather(double temp, int hum) {
    temperature.value = temp;
    humidity.value = hum;
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


  Future<void> loadDashboardChartData({bool showLoading = true,}) async {

    if (showLoading) {
      isLoading.value = true;
    }
    final projectId =
    GetStorage().read(
      AppConstants.projectID,
    );
    final result =
    await _chartUseCase.call(
      DashboardChartParams(
        projectId: projectId,
        period: selectedChartPeriod.value,
      ),
    );
    if (result is DataSuccess) {
      chartData.assignAll(
        result.data!,
      );
    }
    print('010100100101');
    if (showLoading) {
      isLoading.value = false;
    }
  }

  void changeChartPeriod(String period,) {

    selectedChartPeriod.value =
        period;

    loadDashboardChartData();
  }
}
