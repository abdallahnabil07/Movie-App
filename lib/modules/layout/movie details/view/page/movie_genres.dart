import 'package:flutter/material.dart';
import 'package:movie_app/modules/layout/movie%20details/view/widget/genres_widget/genres_widget.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../model/movie_details_model.dart';

class MovieGenres extends StatefulWidget {
  final MovieDetailsModel movieDetailsModel ;

  const MovieGenres({super.key, required this.movieDetailsModel});

  @override
  State<MovieGenres> createState() => _MovieGenresState();
}

class _MovieGenresState extends State<MovieGenres> {
  @override
  Widget build(BuildContext context) {
    var genresList = widget.movieDetailsModel.genres;
    return Padding(
        padding:  EdgeInsets.symmetric(horizontal: context.wd(16),vertical: context.hg(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ [
            Text(
              'Genres',
              style: context.textTheme.titleLarge!.copyWith(
                fontSize: context.hg(24),
                fontWeight: FontWeight.bol),),
              SizedBox(height: context.hg(10),),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,                 // 3 أعمدة
              crossAxisSpacing: 10,              // المسافة بين الأعمدة
              mainAxisSpacing: 10,               // المسافة بين الصفوف
              childAspectRatio:  3.39,             // نسبة ارتفاع/عرض العنصر (تظبط حسب CastWidget)
            ),
            itemCount: genresList.length,
            itemBuilder: (context, index) {
              return GenresWidget(genres: genresList[index],);
            },
          ),
              SizedBox(height:context.hg(50),)
            ],
          ),
        ),
      );
  }
}
