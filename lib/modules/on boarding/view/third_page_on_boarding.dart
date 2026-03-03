import 'package:flutter/material.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/modules/on%20boarding/widget/bottom_container_custom.dart';
import 'package:movie_app/modules/on%20boarding/widget/gradient_custom.dart';

class ThirdPageOnBoarding extends StatelessWidget {
  final int index;

  const ThirdPageOnBoarding({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //image & gradient
        Expanded(
          flex: 7,
          child: Stack(
            children: [
              Assets.images.thirdImageOnBoarding.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              //gradient
              GradientCustom(
                colors: [
                  Color(0xff4C2471).withValues(alpha: 0.0),
                  Color(0xff4C2471).withValues(alpha: 0.3),
                  Color(0xff4C2471).withValues(alpha: 0.6),
                  Color(0xff4C2471).withValues(alpha: 0.9),
                ],
              ),
            ],
          ),
        ),
        //text & EB
        BottomContainerCustom(
          indexForBottomContainer: index,
          topText: 'Create Watch lists',
          flex: 2,
          title:
              "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
        ),
      ],
    );
  }
}
