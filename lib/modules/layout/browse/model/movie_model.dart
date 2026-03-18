class HomeMovieModel {
  final int id;
  final String title;
  final int year;
  final String rating;
  final List<String> genres;
  final String summary;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;

  HomeMovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
    required this.summary,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
  });

  factory HomeMovieModel.fromJson(Map<String, dynamic> json) {
    return HomeMovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: json['rating']?.toString() ?? '0.0',
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
    );
  }

  bool hasGenre(String genre) {
    return genres.contains(genre);
  }
}

class MovieResponse {
  final int status;
  final String statusMessage;
  final MovieData data;

  MovieResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      status: json['status'] ?? 0,
      statusMessage: json['status_message'] ?? '',
      data: MovieData.fromJson(json['data'] ?? {}),
    );
  }
}

class MovieData {
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<HomeMovieModel> movies;

  MovieData({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    var moviesList = json['movies'] as List?;
    List<HomeMovieModel> movies = moviesList?.map((i) => HomeMovieModel.fromJson(i)).toList() ?? [];

    return MovieData(
      movieCount: json['movie_count'] ?? 0,
      limit: json['limit'] ?? 0,
      pageNumber: json['page_number'] ?? 0,
      movies: movies,
    );
  }
}
