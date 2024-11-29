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
      print("Movie Data: ${widget.movie}");
      int likeCount = int.tryParse(widget.movie['like'].toString()) ?? 0;
      print("Like Count: $likeCount");
      isLiked = likeCount > 0;
    });
  }
  Future<void> _toggleLike() async {
    final movieId = widget.movie['_id'];
    const url = 'https://watch-movie-tzae.onrender.com/like'; 

    print("Toggling like for movie ID: $movieId");

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

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Response from server: $responseData");

        if (responseData['success'] == true) {
          setState(() {
            isLiked = !isLiked;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(isLiked ? "Movie liked successfully!" : "Movie unliked successfully!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to like/unlike the movie.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to like the movie. Status Code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
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
                                    builder: (context) => VideoScreen(
                                      videoPath: trailerUrl,
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
                                  onPressed: () {
                                    
                                  },
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
                                  icon: const Icon(Icons.download, color: Colors.white),
                                  onPressed: () {
                                    
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
                                  icon: Icon(
                                    isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.white,
                                  ),
                                  onPressed: _toggleLike, 
                                ),
                                const Text(
                                  "Rate",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
