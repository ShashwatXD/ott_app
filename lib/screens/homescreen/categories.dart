import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/moviedesciptionscreen.dart';
import 'package:ott_app/screens/homescreen/homepage.dart'; 

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final AppDataManager _appDataManager = AppDataManager();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final storage = const FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'token');
    
    if (jwtToken == null) {
      print("Token not found!");
      setState(() => _isLoading = false);
      return;
    }

    // If data is not loaded, fetch it
    if (!_appDataManager.isDataLoaded) {
      await _appDataManager.fetchInitialData(jwtToken);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToDescription(Map<String, dynamic> movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDescriptionScreen(movie: movie),
      ),
    );
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
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  "Loading Categories...",
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
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white),
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
        child: ListView(
          children: [
            const Divider(
              color: Color(0xFF068441),
              thickness: 1,
              height: 0,
            ),
            for (var genre in _appDataManager.genres)
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
                        children: _appDataManager.genreBasedMovies[genre]?.isEmpty ?? true
                            ? [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "No movies available for this genre.",
                                    style: TextStyle(color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ]
                            : _appDataManager.genreBasedMovies[genre]!
                                .map<Widget>((movie) {
                                final title = movie['title'] ?? 'No Title';
                                final posterUrl = movie['poster_url'] ?? '';

                                return GestureDetector(
                                  onTap: () => navigateToDescription(movie),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8)),
                                            child: posterUrl.isNotEmpty
                                                ? Image.network(
                                                    posterUrl,
                                                    width: 150,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (context, error, stackTrace) {
                                                      return const Icon(
                                                        Icons.image_not_supported,
                                                        size: 100,
                                                        color: Colors.grey,
                                                      );
                                                    },
                                                  )
                                                : const Icon(
                                                    Icons.image_not_supported,
                                                    size: 100,
                                                    color: Colors.grey,
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
        ),
      ),
    );
  }
}