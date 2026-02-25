import 'package:flutter/material.dart';

import '../../../core/gen/assets.gen.dart';
import '../widget/bottom_container_custom.dart';
import '../widget/gradient_custom.dart';

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
          flex: 10,
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
          flex: 1,
          indexForBottomContainer: index,
        ),
      ],
    );
  }
}
