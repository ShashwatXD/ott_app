import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WatchlistScreen extends StatefulWidget {
  final String authToken;
  final String movieId;

  const WatchlistScreen({
    Key? key,
    required this.authToken,
    required this.movieId,
  }) : super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  bool _isLoading = true;
  List<dynamic> _watchlistMovies = [];

  @override
  void initState() {
    super.initState();
    _fetchWatchlistMovies();
  }

  Future<void> _fetchWatchlistMovies() async {
    String? token = await _secureStorage.read(key: 'token'); 

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No token found. Please log in.")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://watch-movie-tzae.onrender.com/watchlist'),
        headers: {
          'Authorization': 'Bearer $token', // Send token as Bearer authentication
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> movieData = jsonDecode(response.body);
        setState(() {
          _watchlistMovies = movieData;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load watchlist. Status: ${response.statusCode}")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        backgroundColor: const Color(0xFF04130C),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchWatchlistMovies,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _watchlistMovies.isEmpty
              ? const Center(child: Text("No movies in watchlist"))
              : ListView.builder(
                  itemCount: _watchlistMovies.length,
                  itemBuilder: (context, index) {
                    final movie = _watchlistMovies[index];

                    // Safely access movie data
                    final posterUrl = movie['poster_url'] ?? ''; // Fallback to empty string
                    final title = movie['title'] ?? 'Untitled Movie'; // Fallback to 'Untitled Movie'
                    final year = movie['year'] ?? 'Unknown Year'; // Fallback to 'Unknown Year'

                    return ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: posterUrl.isNotEmpty
                          ? Image.network(posterUrl, width: 50)
                          : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      title: Text(
                        title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        year,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      onTap: () {
                        // You can add navigation to the movie detail screen here
                        // For example, navigate to the MovieDescriptionScreen
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDescriptionScreen(movie: movie)));
                      },
                    );
                  },
                ),
    );
  }
}
