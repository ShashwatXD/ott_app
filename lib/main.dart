import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ott_app/loginservices/lottie.dart';

void main() {
 runApp(const ProviderScope(child: MyApp()));}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'OTT App',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      home: const SplashScreen(), 
    );
  }
}