part of 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialState());

  Future<void> searchMovies(String query) async {
    try {
      emit(LoadingState());
      Map<String, dynamic> queryParameter = {'query_term': query};
      final response = await http.get(
        Uri.http(ApiConstants.domain, EndPoints.movieList, queryParameter),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final movies = data["data"]["movies"] ?? [];
        if (movies.isEmpty) {
          emit(EmptyState());
        } else {
          emit(SuccessState(movieList: movies));
        }
      } else {
        emit(ErrorState(errorMessage: "Status code: ${response.statusCode}"));
      }
    } catch (error) {
      emit(ErrorState(errorMessage: error.toString()));
    }
  }

  Timer? _debounce;

  void onQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: 500), () {
      searchMovies(query);
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
