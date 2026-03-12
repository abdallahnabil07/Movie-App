import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/core/local/cache_helper_.dart';
import 'package:movie_app/core/local/constants/cache_key.dart';
import 'package:movie_app/core/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

import 'components/loading_services.dart';
import 'core/my_bloc_observe.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/app_routes_name.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize();
  await CacheHelper.init();

  runApp(
    MyApp(),
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (BuildContext context) => MyApp(),
    // ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isVisited = CacheHelper.getData(CacheKeys.onBoarding) ?? false;
    bool isLoggedIn = CacheHelper.getData(CacheKeys.isLoggedIn) ?? false;

    String startRoute;

    if (!isVisited) {
      startRoute = AppRoutesName.onBoardingView;
    }
    else if (isLoggedIn) {
      startRoute = AppRoutesName.layout;
    }
    else {
      startRoute = AppRoutesName.login;
    }

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   // useInheritedMediaQuery: true,
    //   // locale: DevicePreview.locale(context),
    //
    //   // builder: (context, child) {
    //   //   child = DevicePreview.appBuilder(context, child);
    //   //   child = EasyLoading.init()(context, child);
    //   //   return child;
    //   // },
    //
    //   theme: AppTheme.appTheme,
    //   title: 'Movie App',
    //   initialRoute: startRoute,
    //   onGenerateRoute: AppRoutes.generateRoute,
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // locale: DevicePreview.locale(context),
        builder: EasyLoading.init(),
        theme: AppTheme.appTheme,
        title: 'Movie app',
        initialRoute: startRoute,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
