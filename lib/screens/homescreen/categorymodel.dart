// categorymodel.dart
class Movie {
  final String movieName;
  final String thumbnail;
  final String videoUrl;
  final List<String> cast;

  Movie({
    required this.movieName,
    required this.thumbnail,
    required this.videoUrl,
    required this.cast,
  });

  // From JSON to Movie object
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieName: json['movie_name'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['video_url'] ?? '',
      cast: List<String>.from(json['cast'] ?? []),
    );
  }
}
