

import '../../domain/entities/chart_entity.dart';

class DashboardChartModel extends DashboardChartEntity {

  DashboardChartModel({
    required super.date,
    required super.averagePower,
    required super.averageEnergy,
    required super.averageVoltage,
  });

  factory DashboardChartModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return DashboardChartModel(
      date: json['date'] ?? '',
      averagePower: (
          json['average_power'] ?? 0
      ).toDouble(),
      averageEnergy: (
          json['average_energy'] ?? 0
      ).toDouble(),
      averageVoltage: (
          json['average_voltage'] ?? 0
      ).toDouble(),
    );
  }
}