import 'package:flutter/material.dart';

import '../../../core/gen/assets.gen.dart';
import '../widget/bottom_container_custom.dart';
import '../widget/gradient_custom.dart';

class FourthPageOnBoarding extends StatelessWidget {
  final int index;

  const FourthPageOnBoarding({super.key, required this.index});

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
              Assets.images.fourthImageOnBoarding.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              //gradient
              GradientCustom(
                colors: [
                  Color(0xff601321).withValues(alpha: 0.0),
                  Color(0xff601321).withValues(alpha: 0.3),
                  Color(0xff601321).withValues(alpha: 0.6),
                  Color(0xff601321).withValues(alpha: 0.9),
                ],
              ),
            ],
          ),
        ),
        //text & EB
        BottomContainerCustom(
          indexForBottomContainer: index,
          topText: 'Rate, Review, and Learn',
          flex: 3,
          title:
              "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
        ),
      ],
    );
  }
}
