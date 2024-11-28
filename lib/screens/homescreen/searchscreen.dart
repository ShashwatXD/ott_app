import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/screens/homescreen/videoplayerscreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> allMovies = [];
  List<dynamic> filteredMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMovies(); 
  }

  Future<void> _fetchMovies() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception("Token is not available");
    }

    final response = await http.get(
      Uri.parse('https://watch-movie-tzae.onrender.com/videos'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> movies = json.decode(response.body);
      setState(() {
        allMovies = movies;
        filteredMovies = []; 
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  void _searchMovies(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredMovies = []; 
      });
    } else {
      setState(() {
        filteredMovies = allMovies
            .where((movie) {
              String title = movie['title'] ?? '';
              return _isSequenceMatch(title.toLowerCase(), query.toLowerCase());
            })
            .toList();
      });
    }
  }

  
  bool _isSequenceMatch(String title, String query) {
    int queryIndex = 0;
    for (int i = 0; i < title.length && queryIndex < query.length; i++) {
      if (title[i] == query[queryIndex]) {
        queryIndex++;
      }
    }
    return queryIndex == query.length;
  }
  void _navigateToVideoPlayer(String trailerUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoPath: trailerUrl),
      ),
    );
  }


  String _truncateOverview(String overview) {
    if (overview.length > 100) { 
      return overview.substring(0, 100) + '...';
    }
    return overview;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
        backgroundColor: Color(0xFF111714), 
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFF111714), 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: _searchMovies,
                  style: TextStyle(color: Colors.white), 
                  decoration: InputDecoration(
                    hintText: '            Search for movies...',
                    hintStyle: TextStyle(color: Color(0xFF5E5D5D).withOpacity(0.5)), 
                    prefixIcon: Icon(Icons.search, color: Colors.white), 
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              searchController.clear();
                              _searchMovies('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              
              Expanded(
                child: filteredMovies.isEmpty && searchController.text.isNotEmpty
                    ? Center(child: Text('No movies found', style: TextStyle(color: Colors.white)))
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10, 
                          mainAxisSpacing: 10, 
                          childAspectRatio: 0.6, 
                        ),
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          var movie = filteredMovies[index];
                          return GestureDetector(
                            onTap: () {
                              _navigateToVideoPlayer(movie['trailer_url']);
                            },
                            child: Card(
                              color: Color(0xFF111714), 
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      movie['poster_url'],
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                 
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      movie['title'],
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, 
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      _truncateOverview(movie['overview']),
                                      style: TextStyle(color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
