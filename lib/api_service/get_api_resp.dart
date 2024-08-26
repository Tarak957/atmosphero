import 'dart:developer';
import 'package:weather_app/api_service/string.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/daily_weather_model.dart';
import 'package:weather_app/model/hourly_weather_model.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  WeatherData? weatherData;
  final Dio dio = Dio();

  Future getWeatherData(lat, lon) async {
    try {
      final response = await dio.get(apiUrl(lat, lon));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final bodyData = response.data;
        weatherData = WeatherData(
          CurrentWeatherData.fromJson(bodyData),
          WeatherDataHourly.fromJson(bodyData),
          WeatherDataDaily.fromJson(bodyData),
        );
        return weatherData;
      } else {
        log('Server Failure');
      }
    } catch (e) {
      log('Client Failure --- ${e.toString()}');
    }
    return WeatherData();
  }
}
