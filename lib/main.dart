import 'package:animal_app/screens/home_Page.dart';
import 'package:animal_app/screens/splash_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_Screen',
      routes: {
        'splash_Screen': (context) => SplashScreen(),
        'home_Page': (context) => HomePage(),
      },
    ),
  );
}
