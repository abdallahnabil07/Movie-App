part of 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitialState());

  Future<void> fetchMovieDetails(int movieID) async {
    try {
      emit(MovieDetailsLoadingState());
      final response = await http.get(
        Uri.https(ApiConstants.domain, EndPoints.movieDetails, {
          "movie_id": movieID.toString(),
          "with_images": "true",
          "with_cast": "true",
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movie = MovieDetailsModel.fromJson(data['data']['movie']);
        emit(MovieDetailsSuccessState(movie: movie));
      } else {
        emit(
          MovieDetailsErrorState(
            errorMessage: "Server Error: ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
}
