import 'package:flutter/material.dart';
import 'package:movie_app/core/routes/widget/page_route_builder_custom.dart';
import 'package:movie_app/modules/Auth/view/login/login_view.dart';
import 'package:movie_app/modules/Auth/view/registration/registration_view.dart';
import 'package:movie_app/modules/layout/layout.dart';
import 'package:movie_app/modules/layout/movie%20details/view/movie_details.dart';
import 'package:movie_app/modules/layout/profile/view/UpdateProfile/update_profile.dart';
import 'package:movie_app/modules/on%20boarding/view/intro_page_on_boarding.dart';
import 'package:movie_app/modules/on%20boarding/view/on_boarding_view.dart';

import '../../modules/Auth/view/forget password/forget_password_screen.dart';
import 'app_routes_name.dart';

abstract class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.introOnBoarding:
        return PageRouteBuilderCustom(page: IntroPageOnBoarding());

      case AppRoutesName.onBoardingView:
        return PageRouteBuilderCustom(page: OnBoardingView());
      case AppRoutesName.forgetPassword:
        return PageRouteBuilderCustom(page: ForgetPasswordScreen());
      case AppRoutesName.login:
        return PageRouteBuilderCustom(page: LoginView());
      case AppRoutesName.registration:
        return PageRouteBuilderCustom(page: RegistrationView());
      case AppRoutesName.updateProfile:
        return PageRouteBuilderCustom(page: UpdateProfile());
      case AppRoutesName.layout:
        return PageRouteBuilderCustom(page: Layout());
      case AppRoutesName.movieDetails:
        return PageRouteBuilderCustom(
          page: MovieDetails(),
          arguments: settings.arguments,
        );
      default:
        return PageRouteBuilderCustom(page: LoginView());
    }
  }
}
