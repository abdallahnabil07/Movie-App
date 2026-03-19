import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_app/components/shimmer_movie_card.dart';
import 'package:movie_app/core/widget/retry_error_widget.dart';
import 'package:movie_app/modules/layout/home/model/home_movie_model.dart';
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
              return ShimmerMovieCard(isMovieDetailsShimmer: true);
            case MovieDetailsErrorState():
              EasyLoading.dismiss();
              return RetryErrorWidget(
                errorMessage: state.errorMessage,
                onPressed: () {
                  movieDetailsCubit.fetchMovieDetails(movie.id);
                },
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
                    SimilarMovies(movieModel: movie),
                    //=================================================

                    //================ Mohammed Gaber =================
                    // Summary
                    MovieSummary(movieModel: movie),
                    //=================================================

                    //================ Youssef ========================
                    // Cast
                    MovieCast(movieDetailsModel: movieDetails),
                    //=================================================

                    //================ Youssef ========================
                    // Genres
                    MovieGenres(movieDetailsModel: movieDetails),
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
