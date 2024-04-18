part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class WeatherFetched extends WeatherEvent {
  final String city;
  final String st;

  WeatherFetched({required this.city, required this.st});
}
