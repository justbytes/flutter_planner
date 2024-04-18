import 'dart:convert';
import 'package:flutter_planner/models/weather_model.dart';
import 'package:flutter_planner/weather/data/data_provider/weather_data_provider.dart';

/* 
________________________________________________________________________________
class WeatherRepository
  Handles data fetch requests for currentWeather and maps it throught model it
    get dot notation
________________________________________________________________________________
*/

class WeatherRepository {
  // Get WeatherDataProvider
  //
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  // getCurrentWeather
  // returns the req.body from the weatherProvider
  Future<WeatherModel> getCurrentWeather(cityName, state) async {
    try {
      // Hard coded examples
      //

      // getCurrentWeather()
      // [cityName] - String of city
      // [state] - String of state
      // returns OpenWeatherAPI current weather data
      //
      final weatherData =
          await weatherDataProvider.getCurrentWeather(cityName, state);

      // Decode the json data
      //
      final data = jsonDecode(weatherData);

      // Check status code from data
      //
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw "From WeatherModel ${e.toString()}";
    }
  }
}
