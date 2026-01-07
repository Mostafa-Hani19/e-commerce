import 'package:ecommerce/core/providers/theme_provider.dart';
import 'package:ecommerce/core/constants/global_keys.dart';
import 'package:ecommerce/core/routes/app_routes.dart';
import 'package:ecommerce/core/routes/route_generator.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: GlobalKeys.scaffoldMessengerKey,
      navigatorKey: GlobalKeys.navigatorKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
