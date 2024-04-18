import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_planner/models/weather_model.dart';
import 'package:flutter_planner/weather/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/* 
________________________________________________________________________________
class WeatherBloc 
  handles state and events 

  WeatherFetched 
    starts the OpenWeatherAPI get Request for current weather data
________________________________________________________________________________
*/

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);
  }

  void _getCurrentWeather(
    WeatherFetched event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather =
          await weatherRepository.getCurrentWeather(event.city, event.st);
      emit(
        WeatherSuccess(weatherModel: weather),
      );
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}
