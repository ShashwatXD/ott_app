import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ott_app/moviedesciptionscreen.dart';

class LikedMoviesScreen extends StatefulWidget {
  final String authToken;
  final String movieId;

  const LikedMoviesScreen({
    Key? key,
    required this.authToken,
    required this.movieId,
  }) : super(key: key);

  @override
  _LikedMoviesScreenState createState() => _LikedMoviesScreenState();
}

class _LikedMoviesScreenState extends State<LikedMoviesScreen> {
  List<dynamic> likedMovies = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchLikedMovies();
  }

  Future<void> _fetchLikedMovies() async {
    try {
      print("Fetching liked movies from the backend...");
      final response = await http.get(
        Uri.parse('https://watch-movie-tzae.onrender.com/like'),
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
      );

      print("API Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        print("Fetched Liked Movies Data: $data");

        setState(() {
          likedMovies = data;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to fetch liked movies (Status Code: ${response.statusCode})';
        });
        print(errorMessage);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching liked movies: $e';
      });
      print(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Movies'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : likedMovies.isEmpty
              ? Center(
                  child: Text(
                    errorMessage.isEmpty ? 'No liked movies found.' : errorMessage,
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: likedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = likedMovies[index];
                    return ListTile(
                      
                      leading: Image.network(
                        
                        movie['poster_url'] ??'',
                        width: 50,
                        height: 75,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                      title: Text(
                        movie['title'] ?? 'Unknown Title',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        movie['overview'] ?? 'No description available.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDescriptionScreen(movie: movie),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

