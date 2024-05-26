import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../manager/app_state_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    context.read<AppStateManager>().initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'assets/logos/sep_logo.svg',
                  width: 200,
                  height: 200,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}