import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'categoryprovider.dart';
import 'package:ott_app/screens/videoplayerscreen.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the movie data state using the provider
    final movieState = ref.watch(movieProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Categories",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Add functionality to search here
            },
          ),
        ],
        backgroundColor: const Color(0xFF04130C),
      ),
      backgroundColor: const Color(0xFF03130B),
      body: movieState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieState.error != null
              ? Center(child: Text('Error: ${movieState.error}'))
              : movieState.movies.isEmpty
                  ? const Center(child: Text('No movies available'))
                  : ListView.builder(
                      itemCount: movieState.movies.length,
                      itemBuilder: (context, index) {
                        final movie = movieState.movies[index];
                        return _buildMovieCard(
                          context,
                          thumbnailUrl: movie.thumbnail,
                          videoUrl: movie.videoUrl,
                        );
                      },
                    ),
    );
  }

  /// Helper method to build a movie card
  Widget _buildMovieCard(
    BuildContext context, {
    required String thumbnailUrl,
    required String videoUrl,
  }) {
    return GestureDetector(
      onTap: () {
        if (videoUrl.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(videoUrl: videoUrl),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Video URL not available")),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                thumbnailUrl,
                width: 160,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  width: 160,
                  height: 100,
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
