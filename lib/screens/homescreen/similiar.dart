import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimilarScreen extends StatefulWidget {
  final String movieTitle;

  const SimilarScreen({Key? key, required this.movieTitle}) : super(key: key);

  @override
  State<SimilarScreen> createState() => _SimilarScreenState();
}

class _SimilarScreenState extends State<SimilarScreen> {
  List<dynamic> similarMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSimilarMovies();
  }

  Future<void> _fetchSimilarMovies() async {
    final url = 'https://api-for-movie-recommendations-1.onrender.com/recommend?movie=${widget.movieTitle}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          similarMovies = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to fetch similar movies. Status Code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
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
        title: const Text("More Like This"),
        backgroundColor: const Color(0xFF03130B),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : similarMovies.isEmpty
              ? const Center(child: Text("No similar movies found."))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: similarMovies.length,
                  itemBuilder: (context, index) {
                    final movie = similarMovies[index];
                    return Card(
                      color: const Color(0xFF03130B),
                      child: Column(
                        children: [
                          Expanded(
                            child: movie['poster_url'] != null
                                ? Image.network(movie['poster_url'], fit: BoxFit.cover)
                                : const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie['title'] ?? "No Title",
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
