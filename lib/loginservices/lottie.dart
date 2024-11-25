import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ott_app/homescreen/firstpage.dart';
import 'package:ott_app/loginservices/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Widget> _determineNextScreen() async {
    final secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'token');
    return token != null ? const BottomNavScreen() : const LoginPage();
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