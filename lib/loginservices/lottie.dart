import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ott_app/homescreen/genre.dart';
import 'package:ott_app/loginservices/login.dart';
import 'package:ott_app/loginservices/signup.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
    
      splash: Image.asset(
        'images/phoenix.png',height: 16,
        
      ),
      nextScreen: LoginPage(), 
      duration: 2200,
      backgroundColor: Colors.white,
    );
  }
}

