class MovieDetailsModel {
  final int id;
  final String title;
  final String description;
  final List<String> screenshots;
  final List<String> cast;
  final List<String> genres;
  final int runtime;
  final double rating;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.screenshots,
    required this.cast,
    required this.genres,
    required this.runtime,
    required this.rating,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description_full'] ?? '',
      screenshots: [
        json['large_screenshot_image1'] ?? '',
        json['large_screenshot_image2'] ?? '',
        json['large_screenshot_image3'] ?? '',
      ],
      cast: json['cast'] != null
          ? List<String>.from(json['cast'].map((actor) => actor['name']))
          : [],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      runtime: json['runtime'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}
