
class Movie {
  final String id;
  final String movieName;
  final String link;
  final String type;
  final List<String> cast;
  final String thumbnail;
  final int like;
  final List<String>? reviews;

  Movie({
    required this.id,
    required this.movieName,
    required this.link,
    required this.type,
    required this.cast,
    required this.thumbnail,
    required this.like,
    this.reviews,
  });


  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      movieName: json['movieName'],
      link: json['link'],
      type: json['type'],
      cast: List<String>.from(json['cast']),
      thumbnail: json['thumbnail'],
      like: json['like'] ?? 0, 
      reviews: json['reviews'] != null ? List<String>.from(json['reviews']) : [],
    );
  }
}
