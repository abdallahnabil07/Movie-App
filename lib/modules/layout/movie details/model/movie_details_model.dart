class MovieDetailsModel {
  final int id;
  final String url;
  final List<String> screenshots;
  final List<CastModel> cast;
  final List<String> genres;
  final int runtime;
  final int likeCount;
  final String trailerCode;

  MovieDetailsModel({
    required this.id,
    required this.url,
    required this.screenshots,
    required this.cast,
    required this.genres,
    required this.runtime,
    required this.trailerCode,
    required this.likeCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      url: json['url'] ?? '',
      screenshots: [
        json['large_screenshot_image1'] ?? '',
        json['large_screenshot_image2'] ?? '',
        json['large_screenshot_image3'] ?? '',
      ],
      cast: json['cast'] != null
          ? List<CastModel>.from(
              json['cast'].map((actor) => CastModel.fromJson(actor)),
            )
          : [],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      runtime: json['runtime'] ?? 0,
      trailerCode: json['yt_trailer_code'] ?? '',
      likeCount: json['like_count'] ?? 0,
    );
  }
}

class CastModel {
  final String name;
  final String character;
  final String images;

  CastModel({
    required this.name,
    required this.character,
    required this.images,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      character: json['character_name'] ?? '',
      images: json['url_small_image'] ?? '',
    );
  }
}
