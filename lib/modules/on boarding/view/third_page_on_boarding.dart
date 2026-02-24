import 'package:flutter/material.dart';

import '../../../core/gen/assets.gen.dart';
import '../widget/bottom_container_custom.dart';
import '../widget/gradient_custom.dart';

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
          flex: 9,
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
          title:
              "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
          flex: 2,
        ),
      ],
    );
  }
}
