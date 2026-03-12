import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMovieCard extends StatelessWidget {
  final bool isTopMovie;
  final bool isSectionShimmer;
  final bool isMovieDetailsShimmer;
  final bool isScreenshotsShimmer;
  final bool isSimilarMoviesShimmer;

  const ShimmerMovieCard({
    super.key,
    this.isTopMovie = false,
    this.isSectionShimmer = false,
    this.isMovieDetailsShimmer = false,
    this.isScreenshotsShimmer = false,
    this.isSimilarMoviesShimmer = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMovieDetailsShimmer) {
      return SingleChildScrollView(
        child: Column(
          spacing: context.hg(16),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            _shimmerBox(
              context,
              width: double.infinity,
              height: context.hg(600),
            ),

            // Watch Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: _shimmerBox(
                context,
                width: double.infinity,
                height: context.hg(55),
                radius: 12,
              ),
            ),

            // Icons Row (heart / clock / star)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: Row(
                children: [
                  Expanded(
                    child: _shimmerBox(
                      context,
                      width: double.infinity,
                      height: context.hg(47),
                      radius: 16,
                    ),
                  ),
                  SizedBox(width: context.wd(8)),
                  Expanded(
                    child: _shimmerBox(
                      context,
                      width: double.infinity,
                      height: context.hg(47),
                      radius: 16,
                    ),
                  ),
                  SizedBox(width: context.wd(8)),
                  Expanded(
                    child: _shimmerBox(
                      context,
                      width: double.infinity,
                      height: context.hg(47),
                      radius: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Screenshots Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: _shimmerBox(
                context,
                width: context.wd(120),
                height: context.hg(24),
              ),
            ),
            // Screenshots
            ...List.generate(
              3,
                  (index) =>
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.wd(16),
                    ),
                    child: _shimmerBox(
                      context,
                      width: double.infinity,
                      height: context.hg(167),
                      radius: 16,
                    ),
                  ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: EdgeInsets.only(
                    left: context.wd(16),
                    right: context.wd(16),
                    bottom: context.hg(16),
                  ),
                  child: _shimmerBox(
                    context,
                    width: context.wd(80),
                    height: context.hg(24),
                  ),
                ),
                // Grid
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: context.wd(16),
                      mainAxisSpacing: context.hg(16),
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) =>
                        _shimmerBox(
                          context,
                          width: double.infinity,
                          height: double.infinity,
                          radius: 12,
                        ),
                  ),
                ),
              ],
            ),
            // Summary Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: _shimmerBox(
                context,
                width: context.wd(100),
                height: context.hg(24),
              ),
            ),

            // Summary Lines
            ...List.generate(
              3,
                  (index) =>
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.wd(16),
                      right: context.wd(16),
                      bottom: context.hg(8),
                    ),
                    child: _shimmerBox(
                      context,
                      width: double.infinity,
                      height: context.hg(16),
                    ),
                  ),
            ),

            // Cast Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: _shimmerBox(
                context,
                width: context.wd(80),
                height: context.hg(24),
              ),
            ),


            // Cast Items
            ...List.generate(
              3,
                  (index) =>
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.wd(16),
                      vertical: context.hg(6),
                    ),
                    child: Row(
                      children: [
                        _shimmerBox(
                          context,
                          width: context.wd(50),
                          height: context.wd(50),
                          radius: 50,
                        ),
                        SizedBox(width: context.wd(12)),
                        Expanded(
                          child: _shimmerBox(
                            context,
                            width: double.infinity,
                            height: context.hg(20),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),

            // Genres Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: _shimmerBox(
                context,
                width: context.wd(90),
                height: context.hg(24),
              ),
            ),

            // Genres Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: Wrap(
                spacing: context.wd(8),
                runSpacing: context.hg(8),
                children: List.generate(
                  8,
                      (index) =>
                      _shimmerBox(
                        context,
                        width: context.wd(80),
                        height: context.hg(36),
                        radius: 8,
                      ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (isSimilarMoviesShimmer) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: context.wd(16),
            mainAxisSpacing: context.hg(16),
          ),
          itemCount: 4,
          itemBuilder: (context, index) =>
              _shimmerBox(
                context,
                width: double.infinity,
                height: double.infinity,
                radius: 12,
              ),
        ),
      );
    }
    if (isSectionShimmer) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wd(16),
          vertical: context.hg(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(
                  context,
                  width: context.wd(100),
                  height: context.hg(20),
                ),
                _shimmerBox(
                  context,
                  width: context.wd(70),
                  height: context.hg(20),
                ),
              ],
            ),
            SizedBox(height: context.hg(12)),
            SizedBox(
              height: context.hg(180),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (_, _) => SizedBox(width: context.wd(8)),
                itemBuilder: (context, index) =>
                    _shimmerBox(
                      context,
                      width: context.wd(120),
                      height: context.hg(180),
                      radius: 8,
                    ),
              ),
            ),
          ],
        ),
      );
    }

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
    }

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

  Widget _shimmerBox(BuildContext context, {
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: AppColors.darkGreyColor,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: AppColors.charcoalGray,
        ),
      ),
    );
  }
}
