import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';
import 'package:movie_app/modules/layout/movie%20details/cubit/movie_details_state.dart';
import 'package:movie_app/modules/layout/movie%20details/view/page/movie_cast.dart';
import 'package:movie_app/modules/layout/movie%20details/view/page/movie_genres.dart';
import 'package:movie_app/modules/layout/movie%20details/view/page/movie_header.dart';
import 'package:movie_app/modules/layout/movie%20details/view/page/movie_screenshots.dart';
import 'package:movie_app/modules/layout/movie%20details/view/page/movie_summary.dart';
import 'package:movie_app/modules/layout/movie%20details/view/page/similar_movies.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late MovieModel movie;
  final MovieDetailsCubit movieDetailsCubit = MovieDetailsCubit();
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is MovieModel) {
        movie = args;
        movieDetailsCubit.fetchMovieDetails(movie.id);
        isLoaded = true;
      }
    }
  }

  @override
  void dispose() {
    movieDetailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        bloc: movieDetailsCubit,
        builder: (context, state) {
          switch (state) {
            case MovieDetailsLoadingState():

              ///TODO: shimmer_flutter
              EasyLoading.show();
              return SizedBox.shrink();
            case MovieDetailsErrorState():
              EasyLoading.dismiss();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.redColor,
                      fontSize: context.hg(20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.wd(16)),
                    child: AppElevatedButton(
                      onPressed: () {
                        movieDetailsCubit.fetchMovieDetails(movie.id);
                      },
                      textButton: 'Try again',
                      height: context.hg(50),
                      width: double.infinity,
                      fontSize: context.hg(18),
                    ),
                  ),
                ],
              );
            case MovieDetailsSuccessState():
              EasyLoading.dismiss();
              final movieDetails = state.movie;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //================ Abdullah Nabil =================
                    // Video + Watch Button + (Favourite / Minutes / Rate)
                    MovieHeader(
                      movieModel: movie,
                      movieDetailsModel: movieDetails,
                    ),
                    //=================================================

                    //================ Mohammed Gaber =================
                    // Screenshots
                    MovieScreenshots(movieDetailsModel: movieDetails),
                    //=================================================

                    //================ Mohammed Eid ===================
                    // Similar Movies
                    SimilarMovies(),
                    //=================================================

                    //================ Mohammed Gaber =================
                    // Summary
                    MovieSummary(movieModel: movie),
                    //=================================================

                    //================ Youssef ========================
                    // Cast
                    MovieCast(movieDetailsModel: movieDetails,),
                    //=================================================

                    //================ Youssef ========================
                    // Genres
                    MovieGenres(movieDetailsModel: movieDetails,),
                    //=================================================
                  ],
                ),
              );
            case MovieDetailsInitialState():
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
