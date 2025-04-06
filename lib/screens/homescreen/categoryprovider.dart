import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ott_app/screens/homescreen/categorymodel.dart';
import 'dart:convert';

final movieNotifierProvider =
    StateNotifierProvider<MovieNotifier, AsyncValue<List<Movie>>>(
  (ref) => MovieNotifier(),
);

class MovieNotifier extends StateNotifier<AsyncValue<List<Movie>>> {
  MovieNotifier() : super(const AsyncValue.loading()) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token == null) {
        throw Exception("Token is not available");
      }

      final response = await http.get(
        Uri.parse('https://watch-movie-tzae.onrender.com/description'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = json.decode(response.body);
        final movies = moviesJson.map((e) => Movie.fromJson(e)).toList();
        state = AsyncValue.data(movies);
      } else {
        throw Exception(
            'Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
