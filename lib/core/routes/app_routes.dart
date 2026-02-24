import 'package:flutter/material.dart';
import 'package:movie_app/login/login_view.dart';
import 'package:movie_app/registration/registration_view.dart';
import 'app_routes_name.dart';

abstract class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.initial:
      case AppRoutesName.login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );

      case AppRoutesName.registration:
        return MaterialPageRoute(
          builder: (_) => const RegistrationView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}