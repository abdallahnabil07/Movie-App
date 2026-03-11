import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../modules/layout/home/model/movie_model.dart';

class MovieService {
  static const String _baseUrl = 'https://yts.bz/api/v2/list_movies.json';

  static Future<List<MovieModel>> fetchMovies({
    String? sortBy,
    String? genre,
  }) async {
    try {
      Map<String, String> queryParams = {};
      if (sortBy != null) queryParams['sort_by'] = sortBy;
      if (genre != null) queryParams['genre'] = genre;

      final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> movies = data['data']['movies'] ?? [];
        
        return movies.map((movie) => MovieModel.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }

  static Future<List<MovieModel>> fetchMovieSuggestions({
    required int movieId,
  }) async {
    try {
      final Uri url = Uri.parse(
        'https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_id=$movieId',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List movies = data['data']?['movies'] ?? [];

        if (movies.isEmpty) {
          return [];
        }

        return movies
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movie suggestions: $e');
    }
  }
}
