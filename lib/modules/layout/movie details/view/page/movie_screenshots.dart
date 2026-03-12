import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/movie%20details/model/movie_details_model.dart';
import 'package:shimmer/shimmer.dart';

class MovieScreenshots extends StatefulWidget {
  final MovieDetailsModel movieDetailsModel;

  const MovieScreenshots({super.key, required this.movieDetailsModel});

  @override
  State<MovieScreenshots> createState() => _MovieScreenshotsState();
}

class _MovieScreenshotsState extends State<MovieScreenshots> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.wd(16),
            right: context.wd(16),
            bottom: context.hg(16),
          ),

          child: Text(
            "Screen Shots",
            style: TextStyle(
              fontSize: context.hg(24),
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.movieDetailsModel.screenshots.length,
          itemBuilder: (context, index) {
            final imageUrl = widget.movieDetailsModel.screenshots[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.hg(10),
                horizontal: context.wd(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: context.hg(167),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    height: context.hg(167),
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image, size: context.hg(40)),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.darkGreyColor,
                    highlightColor: Colors.grey[600]!,
                    child: Container(
                      height: context.hg(167),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.charcoalGray,
                      ),
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    height: context.hg(167),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
