import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/screens/videoplayerscreen.dart'; 

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<dynamic>> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = fetchMovies();
  }

 
  Future<List<dynamic>> fetchMovies() async {
    final storage = FlutterSecureStorage();
   
    final token = await storage.read(key: 'token'); 

    if (token == null) {
      throw Exception("Token is not available");
    }

    final response = await http.get(
      Uri.parse('https://watch-movie-tzae.onrender.com/videos'),
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );
print(response.body);
    if (response.statusCode == 200) {
      try {
   
        final List<dynamic> movies = json.decode(response.body);
        return movies; 
      } catch (e) {
        throw Exception('Failed to parse response: $e');
      }
    } else {
      throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
    }
  }


  void navigateToVideoPlayer(String trailerUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoUrl: trailerUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;

            return ListView(
              children: [
              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "All Movies",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200, 
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            final posterUrl = movie['poster_url'];
                            final title = movie['title'];
                            final trailerUrl = movie['trailer_url'];

                            return GestureDetector(
                              onTap: () {
                                navigateToVideoPlayer(trailerUrl);
                              },
                              child: Card(
                                margin: const EdgeInsets.only(right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      posterUrl,
                                      width: 150,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    //   child: Text(
                                    //     "Genres: ${genres.join(', ')}",
                                    //     style: const TextStyle(fontSize: 12),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No movies available.'));
          }
        },
      ),
    );
  }
}
