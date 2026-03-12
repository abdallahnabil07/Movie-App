import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/components/shimmer_movie_card.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';
import 'package:movie_app/modules/layout/movie%20details/cubit/movie_similar_cubit.dart';
import 'package:movie_app/modules/layout/movie%20details/view/widget/movie_suggestion_card.dart';

class SimilarMovies extends StatefulWidget {
  final MovieModel movieModel;

  const SimilarMovies({super.key, required this.movieModel});

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  late MovieSimilarCubit _movieSimilarCubit;

  @override
  void initState() {
    super.initState();
    _movieSimilarCubit = MovieSimilarCubit();
    _movieSimilarCubit.fetchMovieSuggestions(movieId: widget.movieModel.id);
  }

  @override
  void dispose() {
    _movieSimilarCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieSimilarCubit,
      child: BlocBuilder<MovieSimilarCubit, MovieSimilarState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // التايتل دايمًا ظاهر ✅
              Padding(
                padding: EdgeInsets.only(
                  left: context.wd(16),
                  right: context.wd(16),
                  bottom: context.hg(16),
                ),
                child: Text(
                  "Similar",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: context.hg(24),
                  ),
                ),
              ),

              if (state.isLoading)
                ShimmerMovieCard(isSimilarMoviesShimmer: true)
              else
                if (state.suggestedMovies.isNotEmpty)
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
                    itemCount: state.suggestedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = state.suggestedMovies[index];
                      return MovieSuggestionCard(
                        movie: movie,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesName.movieDetails,
                            arguments: movie,
                          );
                        },
                      );
                    },
                  ),
                )
              else if (state.error != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.hg(32)),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Error loading suggestions',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: context.hg(8)),
                          TextButton(
                            onPressed: () {
                              _movieSimilarCubit.fetchMovieSuggestions(
                                movieId: widget.movieModel.id,
                              );
                            },
                            child: Text(
                              'Retry',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.hg(32)),
                    child: Center(
                      child: Text(
                        'No similar movies found',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}