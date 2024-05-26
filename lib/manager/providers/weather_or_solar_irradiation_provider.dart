import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/models/solar_irradiation_model.dart';
import 'package:solar_energy_prediction/models/weather_model.dart';
import 'package:solar_energy_prediction/services/weather_or_solar_irradiation_service.dart';

class WeatherOrSolarIrradiationProvider extends ChangeNotifier {
  final WeatherOrSolarIrradiationService _solarIrradiationService = WeatherOrSolarIrradiationService();

  SolarIrradiationModel? _solarIrradiation;
  WeatherModel? _weatherData;
  bool _isLoading = false;
  String? _error;

  SolarIrradiationModel? get solarIrradiation => _solarIrradiation;
  WeatherModel? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSolarIrradiationData({
      required double latitude,
      required double longitude,
      required String date }) async {
    _isLoading = true;
    notifyListeners();

    try {
        _solarIrradiation = await _solarIrradiationService.fetchSolarData(
            latitude: latitude, longitude: longitude, date: dateCalculation(date)
        );

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherData({
    required double latitude,
    required double longitude,
     }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weatherData = await _solarIrradiationService.fetchWeatherData(
          latitude: latitude, longitude: longitude
      );

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String dateCalculation(String date) {
    if (date == "today") {
      return DateTime.now().toString();
    } else if (date == "week ago") {
      return DateTime.now().subtract(const Duration(days: 7)).toString();
    } else if (date == "month ago") {
      return DateTime.now().subtract(const Duration(days: 30)).toString();
    }

    return DateTime.now().toString();
  }
}
