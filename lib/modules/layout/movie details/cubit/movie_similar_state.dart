part of 'movie_summary_cubit.dart';

class MovieSummaryState {
  final List<MovieModel> suggestedMovies;
  final bool isLoading;
  final String? error;

  MovieSummaryState({
    this.suggestedMovies = const [],
    this.isLoading = false,
    this.error,
  });

  MovieSummaryState copyWith({
    List<MovieModel>? suggestedMovies,
    bool? isLoading,
    String? error,
  }) {
    return MovieSummaryState(
      suggestedMovies: suggestedMovies ?? this.suggestedMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieSummaryState &&
        other.suggestedMovies == suggestedMovies &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => suggestedMovies.hashCode ^ isLoading.hashCode ^ error.hashCode;
}
