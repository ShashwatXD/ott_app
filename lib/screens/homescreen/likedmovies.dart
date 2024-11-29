import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LikedMoviesScreen extends StatelessWidget {
  final String movieId;
  final String authToken;

  const LikedMoviesScreen({
    Key? key,
    required this.movieId,
    required this.authToken,
  }) : super(key: key);

  Future<Map<String, dynamic>> fetchLikedMovies() async {
    final response = await http.get(
      Uri.parse('https://watch-movie-tzae.onrender.com/like/$movieId'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load liked movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Movies'),
        backgroundColor: const Color(0xFF04130C),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchLikedMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final movies = snapshot.data!['movies'] as List<dynamic>;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(
                    movie['title'], 
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    movie['genre'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                  leading: Image.network(movie['thumbnailUrl']),
                );
              },
            );
          }
        },
      ),
      backgroundColor: const Color(0xFF03130B),
    );
  }
}
