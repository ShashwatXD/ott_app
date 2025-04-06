import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/moviedesciptionscreen.dart';

class AppDataManager {
  static final AppDataManager _instance = AppDataManager._internal();
  
  factory AppDataManager() {
    return _instance;
  }
  
  AppDataManager._internal();

  List<String> _genres = [];
  List<Map<String, dynamic>> _recommendations = [];
  List<Map<String, dynamic>> _movieDescriptions = [];
  Map<String, List<Map<String, dynamic>>> _genreBasedMovies = {};

  List<String> get genres => _genres;
  List<Map<String, dynamic>> get recommendations => _recommendations;
  List<Map<String, dynamic>> get movieDescriptions => _movieDescriptions;
  Map<String, List<Map<String, dynamic>>> get genreBasedMovies => _genreBasedMovies;

  bool get isDataLoaded => _movieDescriptions.isNotEmpty && _genres.isNotEmpty;

  void updateAppData({
    required List<Map<String, dynamic>> movieDescriptions,
    required List<String> genres,
    required List<Map<String, dynamic>> recommendations,
    required Map<String, List<Map<String, dynamic>>> genreBasedMovies
  }) {
    _movieDescriptions = movieDescriptions;
    _genres = genres;
    _recommendations = recommendations;
    _genreBasedMovies = genreBasedMovies;
  }

  Map<String, dynamic> getMovieByTitle(String title) {
    try {
      return _movieDescriptions.firstWhere(
        (movie) => movie["title"] == title,
        orElse: () => {},
      );
    } catch (e) {
      print("Error finding movie: $e");
      return {};
    }
  }

  Future<void> fetchInitialData(String jwtToken) async {
    if (isDataLoaded) return;

    try {
      // Fetch movie descriptions
      final descriptionResponse = await http.get(
        Uri.parse('https://watch-movie-tzae.onrender.com/description'),
        headers: {'Authorization': 'Bearer $jwtToken'},
      );

      if (descriptionResponse.statusCode != 200) {
        print("Failed to fetch movie descriptions: ${descriptionResponse.body}");
        return;
      }

      final List<dynamic> movies = json.decode(descriptionResponse.body);
      final List<Map<String, dynamic>> movieDescriptions = 
          movies.map((movie) => Map<String, dynamic>.from(movie)).toList();

      // Fetch genres
      final genreResponse = await http.get(
        Uri.parse('https://watch-movie-tzae.onrender.com/genre/get'),
        headers: {'Authorization': 'Bearer $jwtToken'},
      );

      if (genreResponse.statusCode != 200) {
        print("Failed to fetch genres: ${genreResponse.body}");
        return;
      }

      final genres = List<String>.from(json.decode(genreResponse.body));

      // Fetch recommendations
      final recommendResponse = await http.post(
        Uri.parse('https://api-genre-based.onrender.com/recommend'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"genres": genres}),
      );

      if (recommendResponse.statusCode != 200) {
        print("Failed to fetch recommendations: ${recommendResponse.body}");
        return;
      }

      final List<dynamic> recommendationsData =
          json.decode(recommendResponse.body)["recommendations"];
      final List<Map<String, dynamic>> recommendations = recommendationsData
          .map((item) => Map<String, dynamic>.from(item))
          .toList();

      final Map<String, List<Map<String, dynamic>>> genreBasedMovies = {};
      for (var genre in genres) {
        genreBasedMovies[genre] = movieDescriptions
            .where((movie) => movie["genres"].contains(genre))
            .toList();
      }

      updateAppData(
        movieDescriptions: movieDescriptions,
        genres: genres,
        recommendations: recommendations,
        genreBasedMovies: genreBasedMovies
      );

      print("Data loaded: ${movieDescriptions.length} movies, ${genres.length} genres");
    } catch (error) {
      print("Error fetching initial data: $error");
    }
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AppDataManager _appDataManager = AppDataManager();
  final storage = const FlutterSecureStorage();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    String? jwtToken = await storage.read(key: 'token');
    if (jwtToken == null) {
      print("Token not found!");
      setState(() => _isLoading = false);
      return;
    }

    await _appDataManager.fetchInitialData(jwtToken);
    
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? jwtToken = await storage.read(key: 'token');
      if (jwtToken == null) {
        print("Token not found!");
        return;
      }

      _appDataManager.updateAppData(
        movieDescriptions: [],
        genres: [],
        recommendations: [],
        genreBasedMovies: {}
      );

      await _appDataManager.fetchInitialData(jwtToken);
    } catch (e) {
      print("Error refreshing data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void navigateToDescription(String movieTitle) {
    final movieDetails = _appDataManager.getMovieByTitle(movieTitle);

    if (movieDetails.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDescriptionScreen(movie: movieDetails),
        ),
      );
    } else {
      print("Movie details not found for title: $movieTitle");
    }
  }

@override
Widget build(BuildContext context) {
  if (_isLoading) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: const Color(0xFF03130B),
              ),
              SizedBox(height: 20),
              Text(
                "This might take a minute...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF03130B),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: Colors.white,
        backgroundColor: const Color(0xFF03130B),
        child: Container(
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
          child: CustomScrollView(
            slivers: [
              if (_appDataManager.recommendations.isNotEmpty)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Recommended for You",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "FOR YOU",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _appDataManager.recommendations.length,
                          itemBuilder: (context, index) {
                            final movie = _appDataManager.recommendations[index];
                            return GestureDetector(
                              onTap: () =>
                                  navigateToDescription(movie["title"] ?? ''),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        movie["poster_url"] ?? '',
                                        height: 150,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      color: Colors.black.withOpacity(0.6),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 6.0),
                                      child: Text(
                                        movie["title"] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
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
              for (var entry in _appDataManager.genreBasedMovies.entries)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${entry.key} Movies",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),

                      
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: entry.value.length,
                          itemBuilder: (context, index) {
                            final movie = entry.value[index];
                            return GestureDetector(
                              onTap: () =>
                                  navigateToDescription(movie["title"] ?? ''),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        movie["poster_url"] ?? '',
                                        height: 150,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      color: Colors.black.withOpacity(0.6),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 6.0),
                                      child: Text(
                                        movie["title"] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
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
          ),
        ),
      ),
    );
  }
}

