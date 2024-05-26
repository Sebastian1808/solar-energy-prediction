import 'package:location/location.dart';
import '../models/location_model.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationModel> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }
    }

     // Check if location permissions are granted
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permissions are denied.');
      }
    }

    // Get the current location
    LocationData locationData = await _location.getLocation();
    return LocationModel(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
    );
  }
}