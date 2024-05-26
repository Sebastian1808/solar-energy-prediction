import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStateManager extends ChangeNotifier {
  static const storage = FlutterSecureStorage();

  bool _initialized = false;
  bool get isInitialized => _initialized;

  initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 2000));

    _initialized = true;

    notifyListeners();
  }

  saveCoordinates(double latitude, double longitude) async {
    await storage.write(key: 'latitude', value: latitude.toString());
    await storage.write(key: 'longitude', value: longitude.toString());
  }
}