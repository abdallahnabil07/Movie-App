part of 'movie_similar_cubit.dart';

class MovieSimilarState {
  final List<MovieModel> suggestedMovies;
  final bool isLoading;
  final String? error;

  MovieSimilarState({
    this.suggestedMovies = const [],
    this.isLoading = false,
    this.error,
  });

  MovieSimilarState copyWith({
    List<MovieModel>? suggestedMovies,
    bool? isLoading,
    String? error,
  }) {
    return MovieSimilarState(
      suggestedMovies: suggestedMovies ?? this.suggestedMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}