import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/models/location_model.dart';
import '../../services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  LocationModel? _location;
  bool _isLoading = false;
  String? _error;

  LocationModel? get location => _location;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      _location = await _locationService.getLocation();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}