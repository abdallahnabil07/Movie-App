import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/extensions/context_extensions.dart';

class ShimmerMovieCard extends StatelessWidget {
  final bool isTopMovie;

  const ShimmerMovieCard({super.key, this.isTopMovie = false});

  @override
  Widget build(BuildContext context) {
    if (isTopMovie) {
      return Shimmer.fromColors(
        baseColor: AppColors.darkGreyColor,
        highlightColor: Colors.grey[600]!,
        child: Container(
          width: context.width * 0.65,
          height: context.hg(340),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.charcoalGray,
          ),
        ),
      );
    } else {
      return Shimmer.fromColors(
        baseColor: AppColors.darkGreyColor,
        highlightColor: Colors.grey[600]!,
        child: Container(
          height: context.hg(180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.charcoalGray,
          ),
        ),
      );
    }
  }
}
