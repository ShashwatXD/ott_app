import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/homescreen/firstpage.dart';

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
    _getToken();
  }

  Future<void> _getToken() async {
    final storage = FlutterSecureStorage();
    jwtToken = await storage.read(key: 'token');
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
    final storage = FlutterSecureStorage();
    final userEmail = await storage.read(key: 'user_email');

    if (userEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User email not found")),
      );
      return;
    }

    if (jwtToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication token is missing")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://watch-movie-tzae.onrender.com/genre'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          'genre': genres,
          'email': userEmail,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'];

        if (message == 'genre updated successfully') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen()), 
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message ?? "Unknown error occurred")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating genre: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
      );
    
  }
}
