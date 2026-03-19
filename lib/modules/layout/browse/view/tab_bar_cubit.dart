import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/modules/layout/browse/view/tab_bar_states.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarInitial());

  List<dynamic> _allMovies = [];
  String? _initialGenre;

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  Future<void> fetchGenres() async {
    emit(TabBarLoading());

    _currentPage = 1;
    _hasMore = true;
    _allMovies.clear();

    await _fetchMovies();
  }

  Future<void> loadMoreMovies() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    _currentPage++;

    await _fetchMovies(loadMore: true);

    _isLoadingMore = false;
  }

  Future<void> _fetchMovies({bool loadMore = false}) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              'https://movies-api.accel.li/api/v2/list_movies.json?page=$_currentPage',
            ),
            headers: {'User-Agent': 'Mozilla/5.0'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['data']['movies'] as List<dynamic>?;

        if (movies == null || movies.isEmpty) {
          _hasMore = false;
          return;
        }

        if (loadMore) {
          _allMovies.addAll(movies);
        } else {
          _allMovies = movies;
        }

        final genreSet = <String>{};

        for (var movie in _allMovies) {
          final movieGenres = movie['genres'] as List<dynamic>?;
          if (movieGenres != null) {
            genreSet.addAll(movieGenres.whereType<String>());
          }
        }

        final genres = genreSet.toList()..sort();

        emit(TabBarLoaded(genres, _allMovies));

        if (_initialGenre != null) {
          final initialIndex = genres.indexOf(_initialGenre!);
          if (initialIndex != -1) {
            emit(TabBarLoaded(genres, _allMovies, initialIndex: initialIndex));
          }
        }
      } else {
        emit(TabBarError('Error ${response.statusCode}'));
      }
    } catch (e) {
      emit(TabBarError(e.toString()));
    }
  }

  void setInitialGenre(String genre) {
    _initialGenre = genre;

    if (state is TabBarLoaded) {
      final loadedState = state as TabBarLoaded;
      final initialIndex = loadedState.genres.indexOf(genre);

      if (initialIndex != -1) {
        emit(
          TabBarLoaded(
            loadedState.genres,
            _allMovies,
            initialIndex: initialIndex,
          ),
        );
      }
    }
  }

  List<dynamic> getMoviesByGenre(String genre) {
    return _allMovies.where((movie) {
      final movieGenres = movie['genres'] as List<dynamic>?;
      return movieGenres?.contains(genre) ?? false;
    }).toList();
  }
}
