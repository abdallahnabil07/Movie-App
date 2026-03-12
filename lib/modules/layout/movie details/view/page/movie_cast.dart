import 'package:flutter/material.dart';
import 'package:movie_app/modules/layout/movie%20details/model/movie_details_model.dart';
import 'package:movie_app/modules/layout/movie%20details/view/widget/cast_widget/cast_widget.dart';

import '../../../../../core/extensions/context_extensions.dart';

class MovieCast extends StatefulWidget {
  final MovieDetailsModel movieDetailsModel;

  const MovieCast({super.key, required this.movieDetailsModel});

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  @override
  Widget build(BuildContext context) {
    final castList = widget.movieDetailsModel.cast;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.wd(16),
        vertical: context.hg(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Cast',
              style: context.textTheme.titleLarge!.copyWith(
                fontSize: context.hg(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.hg(10)),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CastWidget(cast: castList[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: context.hg(8));
              },
              itemCount: castList.length,
            ),
          ],
        ),
      ),
    );
  }
}
