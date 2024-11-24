import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/loginservices/homepage.dart';

class ImageSelectionScreen extends StatefulWidget {
  const ImageSelectionScreen({super.key});

  @override
  ImageSelectionScreenState createState() => ImageSelectionScreenState();
}

class ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<bool> selectedButtons = List<bool>.filled(10, false);
  final List<String> genres = [
    "Romance", "Horror", "Comedy", "Thriller", "Adventure", 
    "Action", "Drama", "Sci-fi", "Mystery", "Romcom",
  ];
  String? jwtToken;

  @override
  void initState() {
    super.initState();
    _getTokenAndCheckGenre();
  }

  Future<void> _getTokenAndCheckGenre() async {
    final storage = FlutterSecureStorage();
    jwtToken = await storage.read(key: 'jwt_token');

    if (jwtToken == null) {
      // Token not found, handle this case (maybe redirect to login)
      return;
    }

    final response = await http.get(
      Uri.parse('https://watch-movie-tzae.onrender.com/genre'),
      headers: {
        'Authorization': 'Bearer $jwtToken', // Use JWT token in header
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final message = responseData['message'];

      if (message == 'more than one login') {
        // User has already selected a genre, redirect to HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } else {
      // Handle error, for example, no genre data found or request failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error checking genre status")),
      );
    }
  }

  void toggleSelection(int index) {
    setState(() {
      selectedButtons[index] = !selectedButtons[index];
    });
  }

  int getSelectedCount() {
    return selectedButtons.where((isSelected) => isSelected).length;
  }

  Future<void> _updateGenre(List<String> genres) async {
    final response = await http.post(
      Uri.parse('https://watch-movie-tzae.onrender.com/choice'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken', // JWT token in header
      },
      body: jsonEncode({
        'genre': genres,
        'email': 'legendshashwat.gkp@gmail.com', // Use the user's email
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final message = responseData['message'];

      if (message == 'genre updated successfully') {
        // Genre successfully updated
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()), // Redirect to home page after genre update
        );
      } else {
        // If genre update fails or any other condition
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error updating genre")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/genere background.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: const Color.fromRGBO(21, 21, 21, 0.8),
              ),
            ),
            const Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Select Your Favourite Genre",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // Genre buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // First column
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  width: 150,
                                  height: 39,
                                  child: ElevatedButton(
                                    onPressed: () => toggleSelection(index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedButtons[index]
                                          ? const Color.fromRGBO(0, 160, 75, 0.4)
                                          : const Color.fromRGBO(0, 160, 75, 0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(15, 70, 41, 1),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      genres[index],
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 16.0),
                          // Second column
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  width: 150,
                                  height: 39,
                                  child: ElevatedButton(
                                    onPressed: () => toggleSelection(index + 5),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedButtons[index + 5]
                                          ? const Color.fromRGBO(0, 160, 75, 0.4)
                                          : const Color.fromRGBO(0, 160, 75, 0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(15, 70, 41, 1),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      genres[index + 5],
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: getSelectedCount() >= 3
                              ? () {
                                  List<String> selectedGenres = [];
                                  for (int i = 0; i < 10; i++) {
                                    if (selectedButtons[i]) {
                                      selectedGenres.add(genres[i]);
                                    }
                                  }
                                  _updateGenre(selectedGenres);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getSelectedCount() >= 3
                                ? const Color.fromRGBO(5, 100, 49, 1)
                                : const Color.fromRGBO(0, 160, 75, 0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
