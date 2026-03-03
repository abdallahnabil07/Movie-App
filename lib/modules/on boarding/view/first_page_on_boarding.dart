import 'package:flutter/material.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/modules/on%20boarding/widget/bottom_container_custom.dart';
import 'package:movie_app/modules/on%20boarding/widget/gradient_custom.dart';

class FirstPageOnBoarding extends StatelessWidget {
  final int index;

  const FirstPageOnBoarding({super.key, required this.index});

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
              Assets.images.firstImageOnBoarding.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              //gradient
              GradientCustom(
                colors: [
                  Color(0xff084250).withValues(alpha: 0.0),
                  Color(0xff084250).withValues(alpha: 0.3),
                  Color(0xff084250).withValues(alpha: 0.6),
                  Color(0xff084250).withValues(alpha: 0.9),
                ],
              ),
            ],
          ),
        ),

        //text & EB
        BottomContainerCustom(
          indexForBottomContainer: index,
          topText: 'Discover Movies',
          title:
              "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
          flex: 2,
        ),
      ],
    );
  }
}
