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
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      summary: json['summary'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'rating': rating,
      'summary': summary,
    };
  }

  factory MovieModel.fromFirestore(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      summary: json['summary'] ?? '',
    );
  }
}
