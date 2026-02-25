import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/local/cache_helper_.dart';
import 'package:movie_app/core/local/constants/cache_key.dart';
import 'package:movie_app/core/theme/app_theme.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/app_routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (BuildContext context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isVisited = CacheHelper.getData(CacheKeys.onBoarding) ?? false;
    String startRoute = isVisited
        ? AppRoutesName.login
        : AppRoutesName.onBoardingView;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.appTheme,
      title: 'Movie app',
      initialRoute: startRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
