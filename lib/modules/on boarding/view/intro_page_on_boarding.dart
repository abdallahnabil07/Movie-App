import 'package:flutter/material.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';

import '../widget/gradient_custom.dart';

class IntroPageOnBoarding extends StatelessWidget {
  const IntroPageOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          //image
          Positioned.fill(
            child: Assets.images.introImageOnBoarding.image(
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          //gradient
          GradientCustom(
            colors: [
              Color(0xff1E1E1E),
              Color(0xff121312).withValues(alpha: 0.5),
              Color(0xff121312).withValues(alpha: 0.9),
              Color(0xff121312),
            ],
          ),
          //texts % elevatedButton
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wd(8),
                vertical: context.hg(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  //text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Find Your Next\nFavorite Movie Here\n",
                          style: context.textTheme.titleMedium!.copyWith(
                            color: AppColors.white,
                            fontSize: context.fs(36),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Get access to a huge library of movies\n to suit all tastes. You will surely like it.",
                          style: context.textTheme.titleMedium!.copyWith(
                            color: AppColors.white.withValues(alpha: .6),
                            fontSize: context.fs(20),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //elevated button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.wd(16),
                      vertical: context.hg(18),
                    ),
                    child: AppElevatedButton(
                      textButton: "Explore Now",
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutesName.onBoardingView,
                          (route) => false,
                        );
                      },
                      height: context.hg(55),
                      fontSize: context.fs(20),
                      textColor: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
