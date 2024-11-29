import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/moviedesciptionscreen.dart'; 

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
      Uri.parse('https://watch-movie-tzae.onrender.com/description'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> movies = json.decode(response.body);
        return movies;
      } catch (e) {
        throw Exception('Failed to parse response: $e');
      }
    } else {
      throw Exception(
          'Failed to load movies. Status Code: ${response.statusCode}');
    }
  }

  List<String> flattenGenres(dynamic genres) {
    if (genres == null) {
      return [];
    }
    if (genres is List) {
      return genres
          .expand((e) => e is List ? e : [e])
          .map((e) => e.toString().trim().toLowerCase())
          .toList();
    } else if (genres is String) {
      return [genres.trim().toLowerCase()];
    }
    return [];
  }

  List<dynamic> filterMoviesByGenre(List<dynamic> movies, String genre) {
    genre = genre.trim().toLowerCase();

    return movies.where((movie) {
      var movieGenres = movie['genres'] ?? [];
      movieGenres = flattenGenres(movieGenres);
      return movieGenres.contains(genre);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF04130C),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF03130B).withOpacity(1),
              const Color(0xFF03130B).withOpacity(0.9),
              const Color(0xFF03130B).withOpacity(0.9),
            ],
            stops: const [0.1, 0.5, 0.9],
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final movies = snapshot.data!;
              List<String> genres = [
                "Romance",
                "Action",
                "Comedy",
                "Drama",
                "Horror",
                "Thriller",
                "Sci-Fi",
                "Fantasy",
                "Adventure",
                "Mystery"
              ];

              return ListView(
                children: [
                  const Divider(
                    color: Color(0xFF068441),
                    thickness: 1,
                    height: 0,
                  ),
                  for (var genre in genres)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            genre,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: filterMoviesByGenre(movies, genre).isEmpty
                                  ? [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          "No movies available for this genre.",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ),
                                    ]
                                  : filterMoviesByGenre(movies, genre)
                                      .map<Widget>((movie) {
                                      final title = movie['title'];
                                      final posterUrl = movie['poster_url'];
                                      final movieData = movie; 

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDescriptionScreen(
                                                movie: movieData, 
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 8),
                                          width: 150,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF03100A),
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(8),
                                                          topRight:
                                                              Radius.circular(8)),
                                                  child: Image.network(
                                                    posterUrl,
                                                    width: 150,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(
                                                        Icons.image_not_supported,
                                                        size: 100,
                                                        color: Colors.grey,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
