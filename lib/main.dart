import 'package:afriflex/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:afriflex/helpers/go_router_navigation_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: AfriflexApp()));
}

class AfriflexApp extends ConsumerStatefulWidget {
  const AfriflexApp({super.key});

  @override
  ConsumerState<AfriflexApp> createState() => _AfriflexAppState();
}

class _AfriflexAppState extends ConsumerState<AfriflexApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'AfriFlex App',
      theme: getAppTheme(context: context, isDarkMode: true),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
