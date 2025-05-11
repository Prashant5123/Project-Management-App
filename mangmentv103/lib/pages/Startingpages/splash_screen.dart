import 'package:flutter/material.dart';

import 'dart:async';

import 'package:mangmentv103/pages/loginregister/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/splash.jpg',
            width: 200,
            height: 200,
            fit: BoxFit.cover, // Adjusts the image to fit within the circle
          ),
        ),
      ),
    );
  }
}
