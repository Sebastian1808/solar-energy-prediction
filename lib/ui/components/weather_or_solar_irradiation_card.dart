import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/helpers/grade_conversion.dart';
import 'package:solar_energy_prediction/manager/providers/weather_or_solar_irradiation_provider.dart';

import '../../manager/app_state_manager.dart';
import '../theme/style.dart';
import 'error_card.dart';
import 'loading_widget.dart';

class WeatherOrSolarIrradiationCard extends StatefulWidget {

  const WeatherOrSolarIrradiationCard({super.key});

  @override
  State<WeatherOrSolarIrradiationCard> createState() => _WeatherOrSolarIrradiationCardState();
}

class _WeatherOrSolarIrradiationCardState extends State<WeatherOrSolarIrradiationCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherOrSolarIrradiationProvider>(
      builder: (context, weatherOrSolarIrradiationProvider, child) {
        if (weatherOrSolarIrradiationProvider.isLoading) {
          return const LoadingWidget();
        }

        if (weatherOrSolarIrradiationProvider.error != null) {

          return ErrorCard(
            message: weatherOrSolarIrradiationProvider.error!,
          );
        } else if (weatherOrSolarIrradiationProvider.solarIrradiation != null) {

          return Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                )
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text(
                    'Solar Irradiation Info',
                    style: Styles.headline2,
                  ),
                  const Divider(thickness: 1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                          onPressed: () async {
                            String latitude = await AppStateManager.storage.read(key: 'latitude') ?? '';
                            String longitude = await AppStateManager.storage.read(key: 'longitude') ?? '';

                            if(!mounted) return;

                            context.read<WeatherOrSolarIrradiationProvider>().fetchSolarIrradiationData(
                              latitude: double.parse(latitude),
                              longitude: double.parse(longitude),
                              date: 'today',
                            );
                          },
                          child: const Text('Today')
                      ),
                      TextButton(
                          onPressed: () async {
                            String latitude = await AppStateManager.storage.read(key: 'latitude') ?? '';
                            String longitude = await AppStateManager.storage.read(key: 'longitude') ?? '';

                            if(!mounted) return;

                            context.read<WeatherOrSolarIrradiationProvider>().fetchSolarIrradiationData(
                              latitude: double.parse(latitude),
                              longitude: double.parse(longitude),
                              date: 'week ago',
                            );
                          },
                          child: const Text('Week Ago')),
                      TextButton(
                          onPressed: () async {
                            String latitude = await AppStateManager.storage.read(key: 'latitude') ?? '';
                            String longitude = await AppStateManager.storage.read(key: 'longitude') ?? '';

                            if(!mounted) return;

                            context.read<WeatherOrSolarIrradiationProvider>().fetchSolarIrradiationData(
                              latitude: double.parse(latitude),
                              longitude: double.parse(longitude),
                              date: 'month ago',
                            );
                          },
                          child: const Text('Month Ago')),
                      TextButton(
                          onPressed: () async {
                            String latitude = await AppStateManager.storage.read(key: 'latitude') ?? '';
                            String longitude = await AppStateManager.storage.read(key: 'longitude') ?? '';

                            if(!mounted) return;

                            context.read<WeatherOrSolarIrradiationProvider>().fetchSolarIrradiationData(
                              latitude: double.parse(latitude),
                              longitude: double.parse(longitude),
                              date: 'month ago',
                            );
                          },
                          child: const Text('Next 30 days')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/logos/icon_irradiation.svg',
                        width: 100,
                        height: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Clear Sky',
                            style: Styles.bodyTextLarge,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'ghi: ${weatherOrSolarIrradiationProvider.solarIrradiation!.irradiance["daily"][0]["clear_sky"]["ghi"]}',
                            style: Styles.bodyText,
                          ),
                          Text(
                            'dni: ${weatherOrSolarIrradiationProvider.solarIrradiation!.irradiance["daily"][0]["clear_sky"]["dni"]}',
                            style: Styles.bodyText,
                          ),
                          Text(
                            'dhi: ${weatherOrSolarIrradiationProvider.solarIrradiation!.irradiance["daily"][0]["clear_sky"]["dhi"]}',
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            'Cloudy Sky',
                            style: Styles.bodyTextLarge,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'ghi: ${weatherOrSolarIrradiationProvider.solarIrradiation!.irradiance["daily"][0]["cloudy_sky"]["ghi"]}',
                            style: Styles.bodyText,
                          ),
                          Text(
                            'dni: ${weatherOrSolarIrradiationProvider.solarIrradiation!.irradiance["daily"][0]["cloudy_sky"]["dni"]}',
                            style: Styles.bodyText,
                          ),
                          Text(
                            'dhi: ${weatherOrSolarIrradiationProvider.solarIrradiation!.irradiance["daily"][0]["cloudy_sky"]["dhi"]}',
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(thickness: 1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.wb_sunny,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            'Sunrise: ',
                            style: Styles.bodyText,
                          ),
                          Text(
                            DateFormat('hh:mm a').format(weatherOrSolarIrradiationProvider.solarIrradiation!.sunrise),
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.sunny_snowing,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            'Sunset: ',
                            style: Styles.bodyText,
                          ),
                          Text(
                            DateFormat('hh:mm a').format(weatherOrSolarIrradiationProvider.solarIrradiation!.sunset),
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (weatherOrSolarIrradiationProvider.weatherData != null) {

          return Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                )
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text(
                    'Weather Information',
                    style: Styles.headline2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network('https://openweathermap.org/img/wn/${weatherOrSolarIrradiationProvider.weatherData!.weather[0]["icon"]}@2x.png'),
                      Text(
                        '${(weatherOrSolarIrradiationProvider.weatherData!.weather[0]["description"])}',
                        style: Styles.bodyTextLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Temperature: ',
                            style: Styles.bodyText,
                          ),
                          Text(
                            '${convertToFahrenheit(weatherOrSolarIrradiationProvider.weatherData!.main["temp"])}°F',
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Humidity: ',
                            style: Styles.bodyText,
                          ),
                          Text(
                            '${(weatherOrSolarIrradiationProvider.weatherData!.main["humidity"])}%',
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Sensation: ',
                            style: Styles.bodyText,
                          ),
                          Text(
                            '${(weatherOrSolarIrradiationProvider.weatherData!.main["feels_like"])}°F',
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Wind Speed: ',
                            style: Styles.bodyText,
                          ),
                          Text(
                            '${(weatherOrSolarIrradiationProvider.weatherData!.wind["speed"])} m/s',
                            style: Styles.bodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        return const LoadingWidget();
      },
    );
  }
}
