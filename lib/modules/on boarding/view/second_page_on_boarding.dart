import 'package:flutter/material.dart';

import '../../../core/gen/assets.gen.dart';
import '../widget/bottom_container_custom.dart';
import '../widget/gradient_custom.dart';

class SecondPageOnBoarding extends StatelessWidget {
  final int index;

  const SecondPageOnBoarding({super.key, required this.index});

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
              Assets.images.secondImageOnBoarding.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              //gradient
              GradientCustom(
                colors: [
                  Color(0xff85210E).withValues(alpha: 0.0),
                  Color(0xff85210E).withValues(alpha: 0.3),
                  Color(0xff85210E).withValues(alpha: 0.6),
                  Color(0xff85210E).withValues(alpha: 0.9),
                ],
              ),
            ],
          ),
        ),
        //text & EB
        BottomContainerCustom(
          topText: 'Explore All Genres',
          indexForBottomContainer: index,
          title:
              "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
          flex: 2,
        ),
      ],
    );
  }
}
