class WeatherModel {
  final num currentTemp;
  final String currentSky;
  final num currentPressure;
  final num currentWindSpeed;
  final num currentHumidity;
  final HourlyWeatherModel hourlyWeather;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyWeather,
  });

  WeatherModel copyWith({
    num? currentTemp,
    String? currentSky,
    num? currentPressure,
    num? currentWindSpeed,
    num? currentHumidity,
    HourlyWeatherModel? hourlyWeatherModel,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      hourlyWeather: hourlyWeather,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyWeather': hourlyWeather.toMap(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];

    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'],
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'],
      currentWindSpeed: currentWeatherData['wind']['speed'],
      currentHumidity: currentWeatherData['main']['humidity'],
      hourlyWeather: HourlyWeatherModel.fromMap(map),
    );
  }
}

class HourlyWeatherModel {
  final List<HourlyData> hourlyData;

  HourlyWeatherModel({required this.hourlyData});

  factory HourlyWeatherModel.fromMap(Map<String, dynamic> map) {
    List<HourlyData> hourlyData = [];
    List<dynamic> dataList = map['list'];
    for (var data in dataList) {
      hourlyData.add(HourlyData.fromMap(data));
    }
    return HourlyWeatherModel(hourlyData: hourlyData);
  }
  Map<String, dynamic> toMap() {
    return {
      'hourlyData': hourlyData.map((data) => data.toMap()).toList(),
    };
  }
}

class HourlyData {
  final num hourTemp;
  final String hourSky;
  final String hourTime;

  HourlyData({
    required this.hourTemp,
    required this.hourSky,
    required this.hourTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'hourTemp': hourTemp,
      'hourSky': hourSky,
      'hourTime': hourTime,
    };
  }

  factory HourlyData.fromMap(Map<String, dynamic> data) {
    return HourlyData(
      hourTemp: data['main']['temp'],
      hourSky: data['weather'][0]['main'],
      hourTime: data['dt_txt'],
    );
  }
}
