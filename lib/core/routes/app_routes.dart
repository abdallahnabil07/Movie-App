import 'package:flutter/material.dart';
import 'package:movie_app/login/login_view.dart';
import 'package:movie_app/registration/registration_view.dart';
import 'app_routes_name.dart';
import 'package:movie_app/modules/on%20boarding/view/intro_page_on_boarding.dart';
import 'package:movie_app/modules/on%20boarding/view/on_boarding_view.dart';
import '../../screens/forget_password_screen.dart';

abstract class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.introOnBoarding:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => IntroPageOnBoarding(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );

      case AppRoutesName.onBoardingView:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => OnBoardingView(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      case AppRoutesName.forgetPassword:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => ForgetPasswordScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
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
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => IntroPageOnBoarding(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
    }
  }
}
