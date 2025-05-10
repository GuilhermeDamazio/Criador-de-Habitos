import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monumental Habits',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.welcome,
      routes: Routes.routes,
    );
  }
}
