import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/homescreen/firstpage.dart';
import 'package:ott_app/homescreen/genre.dart';
import 'package:ott_app/loginservices/forgetpassword.dart';
import 'package:ott_app/loginservices/signup.dart';

final secureStorage = FlutterSecureStorage();

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final tokenProvider = StateProvider<String?>((ref) => null);
final isLoadingProvider = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
  
Future<void> _login(BuildContext context) async {
  if (_formKey.currentState!.validate()) {
    ref.read(isLoadingProvider.notifier).state = true;

    try {
      final response = await http.post(
        Uri.parse('https://watch-movie-tzae.onrender.com/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
        }),
      );

      ref.read(isLoadingProvider.notifier).state = false;

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody is String && responseBody.contains('Incorrect Password')) {
          _showErrorDialog(context, 'Incorrect Password');
        } else if (responseBody is String && responseBody.contains('There is no user')) {
          _showErrorDialog(context, 'No user found with this email');
        } else if (responseBody is String) {
          await secureStorage.write(key: 'token', value: responseBody);
          await secureStorage.write(key: 'user_email', value: _emailController.text.trim());
          
          ref.read(tokenProvider.notifier).state = responseBody;

          final genreResponse = await http.get(
            Uri.parse('https://watch-movie-tzae.onrender.com/genre'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $responseBody',
            },
          );

          final genreResponseBody = jsonDecode(genreResponse.body);

          if (genreResponse.statusCode == 200 && genreResponseBody['message'] == 'first login') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ImageSelectionScreen()),
            );
          } else if (genreResponse.statusCode == 200) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavScreen()),
            );
          } else {
            _showErrorDialog(context, 'Error checking genre. Please try again.');
          }
        }
      } else {
        _showErrorDialog(context, 'Login failed. Please try again.');
      }
    } catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;
      _showErrorDialog(context, 'Network error. Please check your connection.');
    }
  }
}


void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Login Error'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}
 

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpeg'),
              fit: BoxFit.cover,
              opacity: 0.4,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.6),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Image.asset(
                      'images/phoenix.png',
                      height: 200,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      validator: _validateEmail,
                      decoration: InputDecoration(
                        labelText: "Enter your email",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !isPasswordVisible,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            ref.read(passwordVisibilityProvider.notifier).state =
                                !isPasswordVisible;
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPasswordPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF068441),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: isLoading ? null : () => _login(context),
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an Account? Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 290),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
