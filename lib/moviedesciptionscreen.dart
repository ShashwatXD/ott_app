import 'package:flutter/material.dart';
import 'package:ott_app/videoscreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 

class MovieDescriptionScreen extends StatefulWidget {
  final Map<String, dynamic> movie;

  const MovieDescriptionScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDescriptionScreen> createState() => _MovieDescriptionScreenState();
}

class _MovieDescriptionScreenState extends State<MovieDescriptionScreen> {
  bool isExpanded = false;
  bool isLiked = false;

  final FlutterSecureStorage secureStorage = FlutterSecureStorage(); 

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  void _checkIfLiked() {
    setState(() {
      int likeCount = int.tryParse(widget.movie['like'].toString()) ?? 0;
      isLiked = likeCount > 0;
    });
  }

  Future<void> _toggleLike() async {
    final movieId = widget.movie['_id'];
    const url = 'https://watch-movie-tzae.onrender.com/like'; 

    String? token = await secureStorage.read(key: 'token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No token found. Please log in again.")),
      );
      return; 
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'id': movieId, 
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData == 1) { 
          setState(() {
            isLiked = true;
          });
          await secureStorage.write(key: 'movie_id', value: movieId);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Movie liked successfully!")),
          );
        } else if (responseData == 0) { 
          setState(() {
            isLiked = false;
          });
          await secureStorage.delete(key: 'movie_id');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Movie unliked successfully!")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to like the movie. Status Code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
// sending movie id to watchlist api
  Future<void> _addToWatchlist() async {
    final movieId = widget.movie['_id'];
    final movieName = widget.movie['title'] ?? 'Unknown Movie';

    String? token = await secureStorage.read(key: 'token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No token found. Please log in again.")),
      );
      return; 
    }

    const url = 'https://watch-movie-tzae.onrender.com/watchlist';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'id': movieId,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$movieName added to Watchlist!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add movie to watchlist. Status Code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final overview = movie['overview'] ?? "No overview available.";
    final trailerUrl = movie['trailer_url'] ?? "";

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: movie['poster_url'] != null
                    ? Image.network(
                        movie['poster_url'],
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 100,
                      ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF03130B),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie['title'] ?? "No title available",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              movie['year'] ?? "Unknown Year",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              movie['duration'] ?? "Unknown Duration",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          (movie['genres'] ?? []).join('  \u2022  '),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              overview,
                              maxLines: isExpanded ? null : 3,
                              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                isExpanded ? "See Less" : "See More",
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (trailerUrl.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoStreamScreen(
                                      videoUrl: trailerUrl,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Trailer not available")),
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Play",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF056431),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: const Size(200, 50), 
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.playlist_add, color: Colors.white),
                                  onPressed: _addToWatchlist,  
                                ),
                                const Text(
                                  "Watchlist",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.download, color: Colors.white),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Download clicked!")),
                                    );
                                  },
                                ),
                                const Text(
                                  "Download",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share, color: Colors.white),
                                  onPressed: () {
                                    final movieUrl = trailerUrl; 
                                    Share.share('Check out this movie: $movieUrl');
                                  },
                                ),
                                const Text(
                                  "Share",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.white,
                                  ),
                                  onPressed: _toggleLike,
                                ),
                                const Text(
                                  "Like",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
