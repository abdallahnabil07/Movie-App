import 'package:flutter/material.dart';
import 'package:shimmer_flutter/shimmer_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/extensions/context_extensions.dart';

class ShimmerMovieCard extends StatelessWidget {
  final bool isTopMovie;

  const ShimmerMovieCard({super.key, this.isTopMovie = false});

  @override
  Widget build(BuildContext context) {
    if (isTopMovie) {
      // Big movie card
      return Container(
        width: context.width * 0.65,
        height: context.hg(340),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.charcoalGray,
        ),
        child: Shimmer(
          width: context.width * 0.65,
          height: context.hg(340),
          baseColor: AppColors.darkGreyColor,
        ),
      );
    } else {
      // Small movie card
      return Container(
        margin: EdgeInsets.only(right: context.wd(8)),
        width: double.infinity,
        height: context.hg(180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.charcoalGray,
        ),
        child: Shimmer(
          baseColor: AppColors.darkGreyColor,
          width: double.infinity,
          height: context.hg(180),
        ),
      );
    }
  }
}
