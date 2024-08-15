import 'package:flutter/material.dart';
import 'package:cinemapedia/src/config/environment.dart';

class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';
  static const String path = '/home';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text(Environment.theMovieDBKey),
      ),
    );
  }
}