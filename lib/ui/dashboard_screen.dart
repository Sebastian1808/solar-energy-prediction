import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/manager/app_state_manager.dart';
import 'package:solar_energy_prediction/manager/providers/location_provider.dart';
import 'package:solar_energy_prediction/manager/providers/weather_or_solar_irradiation_provider.dart';
import 'package:solar_energy_prediction/ui/components/weather_or_solar_irradiation_card.dart';

import 'components/error_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Marker? tappedMarker;
  Marker? userLocationMarker;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().fetchLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/screens_background_grey.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Center(
                child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                    if (locationProvider.isLoading) {
                      // Show a loading indicator while fetching location
                      return Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          color: Colors.grey.shade200,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                      );
                    }

                    // If an error occurred while fetching location, return an error card
                    if (locationProvider.error != null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ErrorCard(
                            message: locationProvider.error!,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              locationProvider.fetchLocation();
                            },
                            icon: const Icon(Icons.refresh_outlined),
                            label: const Text('Retry'),
                          ),
                        ],
                      );

                    } else if (locationProvider.location != null) {

                      // Save the user's coordinates
                      context.read<AppStateManager>().saveCoordinates(
                          locationProvider.location!.latitude,
                          locationProvider.location!.longitude
                      );

                      // Fetch solar irradiation data, and change view
                      if (dotenv.env['API_KEY_OPEN_WEATHER_IRRADIATION'] != '') {
                        context.read<WeatherOrSolarIrradiationProvider>().fetchSolarIrradiationData(
                          latitude: locationProvider.location!.latitude,
                          longitude: locationProvider.location!.longitude,
                          date: 'today',
                        );
                      } else {
                        context.read<WeatherOrSolarIrradiationProvider>().fetchWeatherData(
                          latitude: locationProvider.location!.latitude,
                          longitude: locationProvider.location!.longitude,
                        );
                      }

                      // Set the camera position to the user's location
                      CameraPosition userLocation = CameraPosition(
                        target: LatLng(locationProvider.location!.latitude, locationProvider.location!.longitude),
                        zoom: 14.4746,
                      );

                      return GoogleMap(
                        initialCameraPosition: userLocation,
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        onTap: (LatLng latLng) {
                          //
                          Future.microtask(() {
                            setState(() {
                              tappedMarker = Marker(
                                markerId: const MarkerId('tapped_marker'),
                                position: latLng,
                                infoWindow: InfoWindow(
                                  title: 'New Location',
                                  snippet: 'Lat: ${latLng.latitude}, Lng: ${latLng.longitude + 10}',
                                ),
                              );
                            });

                            // Save the new coordinates selected by the user
                            context.read<AppStateManager>().saveCoordinates(
                                locationProvider.location!.latitude,
                                locationProvider.location!.longitude
                            );

                            // Refresh Weather or Solar Irradiation data
                            if (dotenv.env['API_KEY_OPEN_WEATHER_IRRADIATION'] != '') {
                              context.read<WeatherOrSolarIrradiationProvider>().fetchSolarIrradiationData(
                                latitude: latLng.latitude,
                                longitude: latLng.longitude,
                                date: 'today',
                              );
                            } else {
                              context.read<WeatherOrSolarIrradiationProvider>().fetchWeatherData(
                                latitude: latLng.latitude,
                                longitude: latLng.longitude,
                              );
                            }
                          });
                        },
                        markers: tappedMarker != null ? <Marker>{tappedMarker!} : {},
                      );
                    }

                    // If location is null, return an error card
                    return const ErrorCard(
                      message: 'An error occurred while fetching location, '
                          'please try again later.' ,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex:4,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const WeatherOrSolarIrradiationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}