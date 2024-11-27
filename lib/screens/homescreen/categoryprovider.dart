import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/screens/homescreen/categorymodel.dart';

final secureStorage = FlutterSecureStorage();

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MoviesNotifier() : super([]);

  Future<void> fetchMovies() async {
    const url = 'https://watch-movie-tzae.onrender.com/videos';

  
    String? token = await _getToken();
    if (token == null) {
      throw Exception("Token not found");
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', 
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        final movies = jsonData.map((movie) => Movie.fromJson(movie)).toList();

        state = movies;
      } else {
        throw Exception('Failed to fetch movies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movies: $e');
      state = []; 
    }
  }

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'jwt_token');
  }
}
final moviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(),
);
