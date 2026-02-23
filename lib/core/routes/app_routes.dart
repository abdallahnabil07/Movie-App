import 'package:flutter/material.dart';

import '../../screens/forget_password_screen.dart';
import 'app_routes_name.dart';

abstract class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.forgetPassword:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
      default:
        return null;
    }
  }
}
