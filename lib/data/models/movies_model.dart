import 'dart:ffi';

class MoviesModel {
  final String movieName;
  final String movieDescription;
  final String movieImageLink;
  final double movieRating;
  final String movieReleaseDate;

  MoviesModel({
    required this.movieName,
    required this.movieDescription,
    required this.movieImageLink,
    required this.movieRating,
    required this.movieReleaseDate,
});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      movieName: json['original_title'],
      movieDescription: json['overview'],
      movieImageLink: json['poster_path'],
      movieRating: json['vote_average'],
      movieReleaseDate: json['release_date'],
    );
  }
}