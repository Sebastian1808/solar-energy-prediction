/// Weather model
class WeatherModel {
  final List<dynamic> weather;
  final Map<String, dynamic> main;
  final Map<String, dynamic> wind;

  /// Instantiate a new Weather with [weather], [main], and [wind]
  WeatherModel({
    required this.weather,
    required this.main,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      weather: json['weather'],
      main: json['main'],
      wind: json['wind'],
    );
  }
}