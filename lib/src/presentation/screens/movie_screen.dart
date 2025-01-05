import 'package:flutter/material.dart';


class MovieScreen extends StatefulWidget {

  static const String name = 'movie_screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.movieId}'),
      ),
    );
  }
}