import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../manager/app_state_manager.dart';
import '../ui/dashboard_screen.dart';
import '../ui/splash_screen.dart';

class AppRouter {
  final AppStateManager appStateManager;

  AppRouter(this.appStateManager);

  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    refreshListenable: appStateManager,
    routes: <RouteBase>[
      GoRoute(
          name: 'splash',
          path: '/',
          builder: (context, state) => const SplashScreen()
      ),
      GoRoute(
        name: 'dashboard',
        path: '/dashboard',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {

      final inSplash = state.fullPath == '/';

      const dashboardLoc = '/dashboard';

      // Redirects the user from the splash screen to the dashboard,
      // we can include other redirections if necessary right after
      // the app is initialized.
      if (appStateManager.isInitialized) {
        if (inSplash) {

          return dashboardLoc;
        }
      }

      return null;
    },
  );
}