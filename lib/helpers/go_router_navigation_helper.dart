import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:afriflex/screens/confirm_payment_screen.dart';
import 'package:afriflex/screens/create_tontine_screen.dart';
import 'package:afriflex/screens/digital_tontine_creation_success_screen.dart';
import 'package:afriflex/screens/digital_tontine_screen.dart';
import 'package:afriflex/screens/enter_amount_screen.dart';
import 'package:afriflex/screens/error_screen.dart';
import 'package:afriflex/screens/home_screen.dart';
import 'package:afriflex/screens/invite_using_username_screen.dart';
import 'package:afriflex/screens/login_screen.dart';
import 'package:afriflex/screens/onboarding_screen.dart';
import 'package:afriflex/screens/otp_screen.dart';
import 'package:afriflex/screens/email_entry_screen.dart';
import 'package:afriflex/screens/pending_request_screens.dart';
import 'package:afriflex/screens/select_from_contacts_screen.dart';
import 'package:afriflex/screens/send_money_screen.dart';
import 'package:afriflex/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final protectedRoutes = {
    AfriflexRoutes.homeRoute,
    AfriflexRoutes.sendMoneyRoute,
    AfriflexRoutes.enterMoneyRoute,
    AfriflexRoutes.confirmPaymentRoute,
    AfriflexRoutes.digitalTontineRoute,
    AfriflexRoutes.createTontineRoute,
    AfriflexRoutes.addMembersRoute,
    AfriflexRoutes.selectFromContactsRoute,
    AfriflexRoutes.inviteUsingUsernameRoute,
    AfriflexRoutes.pendingRequestRoute,
  };

  return GoRouter(
    navigatorKey: _key,
    initialLocation: AfriflexRoutes.onboardingRoute,
    debugLogDiagnostics: true,
    routes: buildRoutes(),
    errorBuilder: (context, state) => const ErrorScreen(),
    redirect: (context, state) {
      // Access the auth state
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.accessToken != null && authState.accessToken!.isNotEmpty;

      // Get the current route
      final currentRoute = state.matchedLocation;

      // Redirect logic
      if (!isLoggedIn && protectedRoutes.contains(currentRoute)) {
        // Redirect to login if trying to access a protected route while not logged in
        return AfriflexRoutes.loginRoute;
      } else if (isLoggedIn &&
          [
            AfriflexRoutes.onboardingRoute,
            AfriflexRoutes.emailEntryRoute,
            AfriflexRoutes.signupRoute,
            AfriflexRoutes.loginRoute,
          ].contains(currentRoute)) {
        // Redirect to home if already logged in and trying to access public routes
        return AfriflexRoutes.homeRoute;
      }

      // No redirect needed
      return null;
    },
  );
});

List<GoRoute> buildRoutes() {
  return [
    GoRoute(
      name: AfriflexRoutes.onboardingRoute,
      path: AfriflexRoutes.onboardingRoute,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.emailEntryRoute,
      path: AfriflexRoutes.emailEntryRoute,
      builder: (context, state) => const EmailEntryScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.signupRoute,
      path: AfriflexRoutes.signupRoute,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.loginRoute,
      path: AfriflexRoutes.loginRoute,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.otpCodeRoute,
      path: AfriflexRoutes.otpCodeRoute,
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.homeRoute,
      path: AfriflexRoutes.homeRoute,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.sendMoneyRoute,
      path: AfriflexRoutes.sendMoneyRoute,
      builder: (context, state) => const SendMoneyScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.enterMoneyRoute,
      path: AfriflexRoutes.enterMoneyRoute,
      builder: (context, state) => const EnterAmountScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.confirmPaymentRoute,
      path: AfriflexRoutes.confirmPaymentRoute,
      builder: (context, state) => const ConfirmPaymentScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.digitalTontineRoute,
      path: AfriflexRoutes.digitalTontineRoute,
      builder: (context, state) => const DigitalTontineScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.createTontineRoute,
      path: AfriflexRoutes.createTontineRoute,
      builder: (context, state) => const CreateTontineScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.addMembersRoute,
      path: AfriflexRoutes.addMembersRoute,
      builder: (context, state) => const DigitalTontineCreationSuccessScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.selectFromContactsRoute,
      path: AfriflexRoutes.selectFromContactsRoute,
      builder: (context, state) => const SelectFromContactsScreen(),
    ),
    GoRoute(
      name: AfriflexRoutes.inviteUsingUsernameRoute,
      path: AfriflexRoutes.inviteUsingUsernameRoute,
      builder: (context, state) => const InviteUsingUsernameUsername(),
    ),
    GoRoute(
      name: AfriflexRoutes.pendingRequestRoute,
      path: AfriflexRoutes.pendingRequestRoute,
      builder: (context, state) => const PendingRequestScreen(),
    ),
  ];
}
