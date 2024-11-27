import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'categorymodel.dart';

// Movie state class to handle loading, success, and error states
class MovieState {
  final bool isLoading;
  final List<Movie> movies;
  final String? error;

  MovieState({
    required this.isLoading,
    required this.movies,
    this.error,
  });

  // A factory to create a loading state
  factory MovieState.loading() => MovieState(isLoading: true, movies: []);

  // A factory for the success state with a list of movies
  factory MovieState.success(List<Movie> movies) =>
      MovieState(isLoading: false, movies: movies);

  // A factory for the error state with an error message
  factory MovieState.error(String error) =>
      MovieState(isLoading: false, movies: [], error: error);
}

// Define a state notifier to manage the state of the movies
class MovieNotifier extends StateNotifier<MovieState> {
  MovieNotifier() : super(MovieState.loading());

  // Fetch movies from the API with authentication using the access token
  Future<void> fetchMovies() async {
    final url = Uri.parse('https://watch-movie-tzae.onrender.com/videos');
    final accessToken = 'YOUR_ACCESS_TOKEN';  // Replace with a valid token
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = jsonDecode(response.body);
        final movies = moviesJson.map((movie) => Movie.fromJson(movie)).toList();
        state = MovieState.success(movies); // Update state with fetched movies
      } else {
        state = MovieState.error('Failed to load movies');
      }
    } catch (error) {
      state = MovieState.error('Failed to fetch movies: $error');
    }
  }
}

// Create a provider for the MovieNotifier
final movieProvider =
    StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier();
});
