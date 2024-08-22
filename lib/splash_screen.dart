import 'dart:async';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home page after 4 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(), // Pushes the logo to the center
                Image.asset(
                  'images/EyeLogo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20), // Spacing between logo and text
                Text(
                  'Glaucoma Detection',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(), // Pushes the GIF to the bottom
                Image.asset(
                  'images/splashGif.gif',
                  width: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

