import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_theme.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/app_routes_name.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      title: 'Movie app',
      initialRoute: AppRoutesName.forgetPassword,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
