import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final resetPasswordProvider = StateNotifierProvider<ResetPasswordNotifier, AsyncValue<String>>((ref) {
  return ResetPasswordNotifier();
});

class ResetPasswordNotifier extends StateNotifier<AsyncValue<String>> {
  ResetPasswordNotifier() : super(const AsyncValue.data(''));

  Future<void> sendResetEmail(String email) async {
    const String apiUrl = "https://watch-movie-tzae.onrender.com/password/reset";

    try {
      state = const AsyncValue.loading();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      final dynamic responseBody = response.body;
      
      if (response.statusCode == 200) {
        state = AsyncValue.data(responseBody.toString());
      } else {
        state = AsyncValue.error(responseBody.toString(), StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error("Error: $e", StackTrace.current);
    }
  }
}

class ForgetPasswordPage extends ConsumerWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordState = ref.watch(resetPasswordProvider);
    final resetPasswordNotifier = ref.read(resetPasswordProvider.notifier);

    final emailController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/background.jpeg'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/phoenix.png',
                  height: 190,width:10000,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Forget Password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
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
                      borderSide: const BorderSide(color: Colors.white),
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
                  onPressed: () {
                    resetPasswordNotifier.sendResetEmail(emailController.text);
                  },
                  child: const Text(
                    "Send Reset Email",
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                resetPasswordState.when(
                  data: (message) => message.isNotEmpty
                      ? Text(
                          message,
                          style: const TextStyle(color: Colors.green),
                        )
                      : const SizedBox.shrink(),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}