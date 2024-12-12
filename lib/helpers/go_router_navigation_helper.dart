import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/screens/error_screen.dart';
import 'package:afriflex/screens/onboarding_screen.dart';
import 'package:afriflex/screens/otp_screen.dart';
import 'package:afriflex/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _key,
    initialLocation: AfriflexRoutes.onboardingRoute,
    debugLogDiagnostics: true,
    routes: buildRoutes(),
    errorBuilder: (context, state) => const ErrorScreen(),
  );
});

List<GoRoute> buildRoutes() {
  return [
    GoRoute(
      name: 'onboarding',
      path: AfriflexRoutes.onboardingRoute,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.signupRoute,
      path: AfriflexRoutes.signupRoute,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.otpCodeRoute,
      path: AfriflexRoutes.otpCodeRoute,
      builder: (context, state) => const OtpScreen(),
    )
  ];
}
