import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/modules/layout/browse/view/tab_bar_states.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarInitial());
  
  List<dynamic> _allMovies = [];
  String? _initialGenre;

  Future<void> fetchGenres() async {
    emit(TabBarLoading());

    try {
      final response = await http.get(
        Uri.parse('https://movies-api.accel.li/api/v2/list_movies.json'),
        headers: {'User-Agent': 'Mozilla/5.0'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['data']['movies'] as List<dynamic>?;

        if (movies != null && movies.isNotEmpty) {
          _allMovies = movies;
          final genreSet = <String>{};

          for (var movie in movies) {
            final movieGenres = movie['genres'] as List<dynamic>?;
            if (movieGenres != null) {
              genreSet.addAll(movieGenres.whereType<String>());
            }
          }

          final genres;
          if (genreSet.isNotEmpty) {
            genres = genreSet.toList()..sort();
          } else {
            genres = ['Action', 'Drama', 'Comedy'];
          }
          
          emit(TabBarLoaded(genres, _allMovies));
          
          // Set initial tab if provided
          if (_initialGenre != null) {
            final initialIndex = genres.indexOf(_initialGenre!);
            if (initialIndex != -1) {
              emit(TabBarLoaded(genres, _allMovies, initialIndex: initialIndex));
            }
          }
        } else {
          emit(TabBarError('No movies found'));
        }
      } else {
        emit(TabBarError('Failed to load genres, code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(TabBarError('Error: ${e.toString()}'));
    }
  }
  
  void setInitialGenre(String genre) {
    _initialGenre = genre;
    if (state is TabBarLoaded) {
      final loadedState = state as TabBarLoaded;
      final initialIndex = loadedState.genres.indexOf(genre);
      if (initialIndex != -1) {
        emit(TabBarLoaded(loadedState.genres, _allMovies, initialIndex: initialIndex));
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
