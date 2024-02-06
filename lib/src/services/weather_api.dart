import 'dart:convert';

import 'package:weather_app/src/models/weather_data.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String apiUrl =
      'https://api.openweathermap.org/data/2.5/onecall?lat=12.9082847623315&lon=77.65197822993314&units=imperial&appid=b143bb707b2ee117e62649b358207d3e';

  Future<Daily> fetchDailyWeather() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print(response.statusCode);
        final Map<String, dynamic> data = json.decode(response.body);
        return Daily.fromJson(data);
      } else {
        throw Exception('Failed to load daily weather data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
