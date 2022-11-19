import 'package:animal_app/screens/choose_plan_screen.dart';
import 'package:animal_app/screens/details_Page.dart';
import 'package:animal_app/screens/home_Page.dart';
import 'package:animal_app/screens/splash_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'home_page': (context) => HomePage(),
        'choose_Page': (context) => ChoosePlanScreen(),
        'detail_Page': (context) => DetailPage(),
      },
    ),
  );
}
