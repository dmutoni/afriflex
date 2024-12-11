import 'package:afriflex/screens/error_screen.dart';
import 'package:afriflex/screens/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _key,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: buildRoutes(),
    errorBuilder: (context, state) => const ErrorScreen(),
  );
});

List<GoRoute> buildRoutes() {
  return [
    GoRoute(
      name: 'onboarding',
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
  ];
}
