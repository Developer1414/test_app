import 'package:flutter/material.dart';
import 'package:test_app/features/authentication/views/login_screen.dart';
import 'package:test_app/features/map/views/map_screen.dart';
import 'package:test_app/main.dart';

class RouteController {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const MapScreen(),
        );
      case '/authentication':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const MainApp(),
        );
    }
  }
}
