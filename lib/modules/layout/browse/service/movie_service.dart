import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class MovieService {
  static const String baseUrl = 'https://yts.mx/api/v2';

  static Future<MovieResponse> fetchMovies() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/list_movies.json'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MovieResponse.fromJson(data);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }

  static Future<MovieResponse> fetchMoviesByGenre(String genre) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/list_movies.json?genre=$genre'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MovieResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to load movies by genre: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movies by genre: $e');
    }
  }
  static List<String> extractAllGenres(List<HomeMovieModel> movies) {
    Set<String> uniqueGenres = {};

    for (var movie in movies) {
      for (var genre in movie.genres) {
        uniqueGenres.add(genre);
      }
    }

    List<String> genreList = uniqueGenres.toList();
    genreList.sort(); // Sort alphabetically

    return genreList;
  }

  static List<HomeMovieModel> filterMoviesByGenre(List<HomeMovieModel> movies, String genre) {
    if (genre.isEmpty) return movies;

    return movies.where((movie) => movie.hasGenre(genre)).toList();
  }
}
