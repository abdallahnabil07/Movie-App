import 'package:flutter/material.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';

import '../../features/UpdateProfile/update_profile.dart';


abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.updateProfile:
        return MaterialPageRoute(builder: (context) => UpdateProfile(),
        settings: settings,
        );

    }
  }
}
