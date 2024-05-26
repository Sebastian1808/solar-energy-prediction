/// SolarIrradiation model
class SolarIrradiationModel {
  final DateTime sunrise;
  final DateTime sunset;
  final Map<String, dynamic> irradiance;

/// Instantiate a new SolarIrradiationModel with [sunrise], [sunset] and [irradiance]
  SolarIrradiationModel({
    required this.sunrise,
    required this.sunset,
    required this.irradiance,
  });

  factory SolarIrradiationModel.fromJson(Map<String, dynamic> json) {
    return SolarIrradiationModel(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      irradiance: json['irradiance'],
    );
  }
}