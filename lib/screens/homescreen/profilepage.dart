import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/loginservices/login.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    final storage = FlutterSecureStorage();
    final email = await storage.read(key: 'user_email');
    setState(() {
      userEmail = email ?? 'Unknown User';
    });
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
                await secureStorage.delete(key: 'token');
                await secureStorage.delete(key: 'user_email');
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

  Future<void> _deleteAccount() async {
  final secureStorage = FlutterSecureStorage();
  final token = await secureStorage.read(key: 'token');

  if (token != null) {
    try {
      // Make request to delete the account from backend
      final response = await http.get(
        Uri.parse('https://watch-movie-tzae.onrender.com/delete'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Account deleted');

        await secureStorage.delete(key: 'token');
        await secureStorage.delete(key: 'user_email');

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        print('Failed to delete account');
      }
    } catch (e) {
      print('Error deleting account: $e');
    }
  }
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
                            color: Color.fromRGBO(28, 63, 44, 1),
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
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.thumb_up, color: Colors.white),
                          title: const Text("Liked Movies", style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        const Divider(color: Color.fromRGBO(27, 69, 45, 1)),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text("Log Out", style: TextStyle(color: Colors.red)),
                          onTap: () => _logout(context),  ),
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