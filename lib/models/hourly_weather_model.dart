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

  factory HourlyData.fromMap(Map<String, dynamic> data) {
    return HourlyData(
      hourTemp: data['main']['temp'],
      hourSky: data['weather'][0]['main'],
      hourTime: data['dt_txt'],
    );
  }
}
