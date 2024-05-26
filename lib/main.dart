import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy_prediction/manager/providers/location_provider.dart';
import 'package:solar_energy_prediction/manager/providers/weather_or_solar_irradiation_provider.dart';
import 'package:solar_energy_prediction/ui/theme/solar_energy_prediction_theme.dart';

import 'manager/app_state_manager.dart';
import 'navigation/app_router.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  runApp(const SolarEnergyPrediction());
}

class SolarEnergyPrediction extends StatefulWidget {
  const SolarEnergyPrediction({super.key});

  @override
  State<SolarEnergyPrediction> createState() => _SolarEnergyPredictionState();
}

class _SolarEnergyPredictionState extends State<SolarEnergyPrediction> {
  final _appStateManager = AppStateManager();

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
        settings: PlatformSettingsData(
          platformStyle: const PlatformStyleData(android: PlatformStyle.Material),
        ),
        builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => _appStateManager,
              ),
              Provider<AppRouter>(
                create: (context) => AppRouter(_appStateManager),
              ),
              ChangeNotifierProvider(
                  create: (context) => LocationProvider()
              ),
              ChangeNotifierProvider(
                  create: (context) => WeatherOrSolarIrradiationProvider()
              ),
            ],
            child: Builder(
              builder: (BuildContext context) {
                final router = context.read<AppRouter>().router;

                return PlatformApp.router(
                  routeInformationProvider: router.routeInformationProvider,
                  routeInformationParser: router.routeInformationParser,
                  routerDelegate: router.routerDelegate,
                  debugShowCheckedModeBanner: false,
                  title: 'Solar Energy Prediction',
                  material: (_, __) =>
                      MaterialAppRouterData(theme: SolarEnergyPredictionMaterialTheme.light()),
                  cupertino: (_, __) =>
                      CupertinoAppRouterData(theme: SolarEnergyPredictionCupertinoTheme.light()),
                );
              },
            )
        )
    );
  }
}