import 'dart:convert';

import 'package:flutter_planner/models/hourly_weather_model.dart';
import 'package:flutter_planner/models/weather_model.dart';
import 'package:flutter_planner/weather/data/data_provider/weather_data_provider.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'Austin';
      String state = 'Texas';
      final weatherData =
          await weatherDataProvider.getCurrentWeather(cityName, state);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw "From WeatherModel ${e.toString()}";
    }
  }

  Future<HourlyWeatherModel> getHourlyWeather() async {
    try {
      String cityName = 'Austin';
      String state = 'Texas';
      final weatherData =
          await weatherDataProvider.getCurrentWeather(cityName, state);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return HourlyWeatherModel.fromMap(data);
    } catch (e) {
      throw "From HourlyWeatherModel ${e.toString()}";
    }
  }
}
