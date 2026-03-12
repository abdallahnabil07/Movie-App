import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/services/movie_service.dart';
import '../../home/model/movie_model.dart';

part 'movie_summary_state.dart';

class MovieSummaryCubit extends Cubit<MovieSummaryState> {
  MovieSummaryCubit() : super( MovieSummaryState());

  Future<void> fetchMovieSuggestions({required int movieId}) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final suggestions = await MovieService.fetchMovieSuggestions(movieId: movieId);
      emit(state.copyWith(
        suggestedMovies: suggestions,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }
}
