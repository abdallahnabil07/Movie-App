import 'package:flutter/material.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/theme/app_colors.dart';

class MovieSummary extends StatefulWidget {
  final MovieModel movieModel;

  const MovieSummary({super.key, required this.movieModel});

  @override
  State<MovieSummary> createState() => _MovieSummaryState();
}

class _MovieSummaryState extends State<MovieSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.hg(16),
        horizontal: context.wd(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary",
            style: TextStyle(
              fontSize: context.hg(24),
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: context.hg(5)),
          Text(
            widget.movieModel.summary,
            style: TextStyle(
              fontSize: context.hg(16),
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
