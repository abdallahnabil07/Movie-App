import 'package:movie_app/modules/Auth/view/login/login_view.dart';
import 'package:movie_app/modules/Auth/view/registration/registration_view.dart';
import 'package:movie_app/modules/on%20boarding/view/intro_page_on_boarding.dart';
import 'package:movie_app/modules/on%20boarding/view/on_boarding_view.dart';

import '../../modules/Auth/view/forget password/forget_password_screen.dart';
import 'app_routes_name.dart';

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
      case AppRoutesName.login:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => LoginView(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      case AppRoutesName.registration:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => RegistrationView(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
case AppRoutesName.updateProfile:
        return PageRouteBuilder(pageBuilder: (_, _, _)=>UpdateProfile(),
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (_, animation, _, child) {
return FadeTransition(opacity: animation, child: child);
    }
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
