import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/loginservices/login.dart';
import 'package:ott_app/loginservices/homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Widget> _determineNextScreen() async {
    final secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'token');
    return token != null ? const HomePage() : const LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset(
        'images/phoenix.png', 
        height: 160,
      ),
      screenFunction: () => _determineNextScreen(),
      duration: 2200,
      backgroundColor: Colors.white,
    );
  }
}