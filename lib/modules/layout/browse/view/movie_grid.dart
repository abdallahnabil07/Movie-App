import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/model/home_movie_model.dart';
import '../../home/widget/movie_slider_card.dart';
import 'tab_bar_cubit.dart';
import 'tab_bar_states.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        if (state is TabBarLoaded) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final currentIndex = controller.index;
              final selectedGenre = state.genres[currentIndex];

              final movies = context.read<TabBarCubit>().getMoviesByGenre(
                selectedGenre,
              );

              if (movies.isEmpty) {
                return const Center(child: Text("No movies found"));
              }

              return GridView.builder(
                // padding: const EdgeInsets.all(12),
                itemCount: movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final movieJson = movies[index];

                  final movie = MovieModel.fromJson(movieJson);

                  return MovieSliderCard(movie: movie);
                },
              );
            },
          );
        }

        if (state is TabBarError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}