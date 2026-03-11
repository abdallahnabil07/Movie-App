import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/routes/app_routes_name.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widget/movie_suggestion_card.dart';
import '../../cubit/movie_summary_cubit.dart';

class MovieSummary extends StatefulWidget {
  final MovieModel movieModel;

  const MovieSummary({super.key, required this.movieModel});

  @override
  State<MovieSummary> createState() => _MovieSummaryState();
}

class _MovieSummaryState extends State<MovieSummary> {
  late MovieSummaryCubit _movieSummaryCubit;

  @override
  void initState() {
    super.initState();
    _movieSummaryCubit = MovieSummaryCubit();
    _movieSummaryCubit.fetchMovieSuggestions(movieId: widget.movieModel.id);
  }

  @override
  void dispose() {
    _movieSummaryCubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieSummaryCubit,
      child: BlocBuilder<MovieSummaryCubit, MovieSummaryState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: context.wd(16)),
                child: Text(
                  "Similar",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (state.isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.hg(32)),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                )
              else if (state.suggestedMovies.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2/3,
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
                )
              else if (state.error != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.hg(32)),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Error loading suggestions',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: context.hg(8)),
                        TextButton(
                          onPressed: () {
                            _movieSummaryCubit.fetchMovieSuggestions(movieId: widget.movieModel.id);
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                      ),
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
