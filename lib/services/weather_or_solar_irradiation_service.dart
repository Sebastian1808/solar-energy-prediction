import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' show get;
import 'package:solar_energy_prediction/models/solar_irradiation_model.dart';

import '../models/weather_model.dart';

class WeatherOrSolarIrradiationService {
  final String apiKeyWeather = dotenv.env['API_KEY_OPEN_WEATHER'] ?? '';
  final String apiKeyIrradiation = dotenv.env['API_KEY_OPEN_WEATHER_IRRADIATION'] ?? '';

  final String _baseUrl = dotenv.env['API_URL_OPEN_WEATHER'] ?? '';

  late Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<SolarIrradiationModel> fetchSolarData({
    required double latitude,
    required double longitude,
    required String date }) async {

    final response = await get(
        Uri.parse("$_baseUrl/energy/1.0/solar/data?lat=$latitude&lon=$longitude&date=$date&appid=$apiKeyIrradiation"),
        headers: headers,
    );

    if (response.statusCode == 200) {
      return SolarIrradiationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load solar data');
    }
  }

  Future<WeatherModel> fetchWeatherData({
    required double latitude,
    required double longitude }) async {

    final response = await get(
      Uri.parse("$_baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKeyWeather"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
