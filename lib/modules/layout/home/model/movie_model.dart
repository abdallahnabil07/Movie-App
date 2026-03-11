class MovieModel {
  final int id;
  final String title;
  final String image;
  final double rating;
  final String summary;

  MovieModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.summary,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      image: json['large_cover_image'],
      rating: (json['rating'] as num).toDouble(),
      summary: json['summary'] ?? '',
    );
  }
}
