
import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(MyApp()); // Run the App

// Main App root
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // App that uses Material
    return MaterialApp(
      // Set the App theme to purple[900]
      theme: ThemeData(primaryColor: Colors.purple[900]),
      // App home widget
      home: RandomWords()
    );
  }
}

