import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ott_app/loginservices/login.dart';
import 'package:ott_app/screens/homescreen/changepass.dart';
import 'package:ott_app/screens/homescreen/likedmovies.dart';
import 'dart:convert';

import 'package:ott_app/watchlist.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? userEmail;
  String? authToken;
  String? movieId;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }
  Future<void> _fetchMovieIdFromAPI() async {
    try {
      final response = await http.get(
        Uri.parse('https://watch-movie-tzae.onrender.com/description'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movieIdString = data[1]['movie_id'].toString();

        final storage = FlutterSecureStorage();
        await storage.write(key: 'movie_id', value: movieIdString);

        setState(() {
          this.movieId = movieIdString;
        });
      }
    } catch (e) {
      print('Error fetching movie data: $e');
    }
  }

  Future<void> _getUserData() async {
    final storage = FlutterSecureStorage();

    final email = await storage.read(key: 'user_email');
    final token = await storage.read(key: 'token');
    final movie = await storage.read(key: 'movie_id');

    setState(() {
      userEmail = email ?? 'Unknown User';
      authToken = token;
      movieId = movie;
    });

    if (movieId == null) {
      await _fetchMovieIdFromAPI();
    }
  }

  Future<void> _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you really want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () async {
                final secureStorage = FlutterSecureStorage();
                await secureStorage.deleteAll();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Once you delete your account, it cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    if (authToken != null) {
      try {
        final response = await http.delete(
          Uri.parse('https://watch-movie-tzae.onrender.com/delete'),
          headers: {'Authorization': 'Bearer $authToken'},
        );

        if (response.statusCode == 200) {
          final secureStorage = FlutterSecureStorage();
          await secureStorage.deleteAll();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        print('Error deleting account: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(16, 32, 23, 1.0),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromRGBO(28, 63, 44, 1),
                            width: 6,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userEmail ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        ListTile(
                          leading: const Icon(Icons.file_download, color: Colors.white),
                          title: const Text("Downloads", style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.bookmark, color: Colors.white),
                          title: const Text("Watchlist", style: TextStyle(color: Colors.white)),
                          onTap: () {
                            if (authToken != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WatchlistScreen(
                                    authToken: authToken!,
                                    movieId: movieId!,),
                                ),
                              );
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.thumb_up, color: Colors.white),
                          title: const Text("Liked Movies", style: TextStyle(color: Colors.white)),
                          onTap: () {
                            if (authToken != null && movieId != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LikedMoviesScreen(
                                    authToken: authToken!,
                                    movieId: movieId!,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        ListTile(
  leading: const Icon(Icons.lock, color: Colors.white),
  title: const Text("Change Password", style: TextStyle(color: Colors.white)),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
    );
  },
),
                        const Divider(color: Color.fromRGBO(27, 69, 45, 1)),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text("Log Out", style: TextStyle(color: Colors.red)),
                          onTap: () => _logout(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete, color: Colors.red),
                          title: const Text("Delete Account", style: TextStyle(color: Colors.red)),
                          onTap: _showDeleteConfirmationDialog,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
