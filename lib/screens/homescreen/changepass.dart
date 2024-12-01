import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool isLoading = false;
  List<PasswordCriterion> passwordCriteria = [
    PasswordCriterion("At least 6 characters", (p) => p.length >= 6),
    PasswordCriterion("Contains a digit", (p) => RegExp(r'(?=.*?[0-9])').hasMatch(p)),
    PasswordCriterion("Contains a special character", (p) => RegExp(r'(?=.*?[!@#$%^&*(),.?":{}|<>])').hasMatch(p)),
    PasswordCriterion("Contains an uppercase letter", (p) => RegExp(r'(?=.*?[A-Z])').hasMatch(p)),
  ];

  String? errorMessage;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void validatePassword(String password) {
    setState(() {
      for (var criterion in passwordCriteria) {
        criterion.isValid = criterion.validator(password);
      }
    });
  }

  Future<void> _changePassword() async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      _showErrorDialog("New password and confirm password do not match.");
      return;
    }

    if (!passwordCriteria.every((element) => element.isValid)) {
      _showErrorDialog("Password does not meet the required criteria.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final token = await _secureStorage.read(key: 'token');
      if (token == null) {
        _showErrorDialog("Authentication token not found. Please log in again.");
        return;
      }

      final response = await http.post(
        Uri.parse('https://watch-movie-tzae.onrender.com/changePass'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody == "password chnaged") {
          _showSuccessDialog("Password changed successfully.");
        } else {
          _showErrorDialog(responseBody);
        }
      } else {
        _showErrorDialog("Failed to change password. Please try again.");
      }
    } catch (e) {
      _showErrorDialog("An error occurred. Please try again later.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Navigate back to the profile page
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordCriteriaList() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password Requirements:",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ...passwordCriteria.map((criterion) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(
                  criterion.isValid ? Icons.check_circle : Icons.cancel,
                  color: criterion.isValid ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  criterion.description,
                  style: TextStyle(
                    color: criterion.isValid ? Colors.green[200] : Colors.red[200],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
          if (!isLoading)
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextField(
                      controller: oldPasswordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Old Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: newPasswordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      onChanged: (value) {
                        validatePassword(value);
                      },
                      decoration: InputDecoration(
                        labelText: "New Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: confirmPasswordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // New password criteria list
                    _buildPasswordCriteriaList(),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _changePassword,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                        child: Text(
                          "Change Password",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// New class to represent password criteria
class PasswordCriterion {
  final String description;
  final bool Function(String) validator;
  bool isValid;

  PasswordCriterion(this.description, this.validator, {this.isValid = false});
}