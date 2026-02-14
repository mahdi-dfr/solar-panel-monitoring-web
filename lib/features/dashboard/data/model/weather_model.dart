import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.city,
    required super.tempC,
    required super.humidity,
    required super.condition,
    required super.windKph,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'],
      tempC: (json['temp_c'] as num).toDouble(),
      humidity: json['humidity'],
      condition: json['condition'],
      windKph: (json['wind_kph'] as num).toDouble(),
    );
  }
}
