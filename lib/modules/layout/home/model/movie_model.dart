class MovieModel {
  final int id;
  final String title;
  final String image;
  final double rating;
  final String summary;
  final List<String> genres;
  final List<String> screenshots;

  MovieModel({
    required this.title,
    required this.image,
    required this.rating,
    required this.id,
    required this.summary,
    required this.genres,
    required this.screenshots,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      image: json['large_cover_image'],
      rating: (json['rating'] as num).toDouble(),
      summary: json['summary'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      screenshots: [
        json['large_screenshot_image1'] ?? '',
        json['large_screenshot_image2'] ?? '',
        json['large_screenshot_image3'] ?? '',
      ],
    );
  }
}
