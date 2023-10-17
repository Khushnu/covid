
import 'package:covid/Views/splash_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue
      ),
      home: const SplashScreen(),
    );
  }
}