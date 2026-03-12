import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/movie_service.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';

part 'movie_similar_state.dart';

class MovieSimilarCubit extends Cubit<MovieSimilarState> {
  MovieSimilarCubit() : super(MovieSimilarState());

  Future<void> fetchMovieSuggestions({required int movieId}) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final suggestions = await MovieService.fetchMovieSuggestions(
        movieId: movieId,
      );
      emit(state.copyWith(suggestedMovies: suggestions, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }
}
