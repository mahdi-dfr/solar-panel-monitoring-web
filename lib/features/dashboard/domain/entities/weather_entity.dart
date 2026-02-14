class WeatherEntity {
  final String city;
  final double tempC;
  final int humidity;
  final String condition;
  final double windKph;

  WeatherEntity({
    required this.city,
    required this.tempC,
    required this.humidity,
    required this.condition,
    required this.windKph,
  });
}
