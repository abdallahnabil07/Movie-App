import 'package:flutter/material.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/modules/on%20boarding/widget/bottom_container_custom.dart';
import 'package:movie_app/modules/on%20boarding/widget/gradient_custom.dart';

class EndPageOnBoarding extends StatelessWidget {
  final int index;

  const EndPageOnBoarding({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //image & gradient
        Expanded(
          flex: 8,
          child: Stack(
            children: [
              Assets.images.endImageOnBoarding.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              //gradient
              GradientCustom(
                colors: [
                  Color(0xff2A2C30).withValues(alpha: 0.0),
                  Color(0xff2A2C30).withValues(alpha: 0.3),
                  Color(0xff2A2C30).withValues(alpha: 0.6),
                  Color(0xff2A2C30).withValues(alpha: 0.9),
                ],
              ),
            ],
          ),
        ),
        //text & EB
        BottomContainerCustom(
          topText: 'Start Watching Now',
          indexForBottomContainer: index,
          flex: 1,
        ),
      ],
    );
  }
}
