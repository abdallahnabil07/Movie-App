import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/local/cache_helper_.dart';
import 'package:movie_app/core/local/constants/cache_key.dart';
import 'package:movie_app/core/theme/app_theme.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/app_routes_name.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  runApp(
    MyApp(),
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (BuildContext context) => MyApp(),
    // ),
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
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      theme: AppTheme.appTheme,
      title: 'Movie app',
      initialRoute:AppRoutesName.layout ,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
