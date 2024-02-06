class Daily {
  double temperature;
  int pressure;
  int humidity;
  double windSpeed;
  int clouds;

  Daily({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.clouds,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      temperature: json['current']['temp']?.toDouble() ?? 0.0,
      pressure: json['current']['pressure'] ?? 0,
      humidity: json['current']['humidity'] ?? 0,
      windSpeed: json['current']['wind_speed']?.toDouble() ?? 0.0,
      clouds: json['current']['clouds'] ?? 0,
    );
  }
}
