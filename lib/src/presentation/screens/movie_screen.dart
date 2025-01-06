import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const String name = 'movie_screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId
  });

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {

  bool isLoading = true;
  Movie? movie;

  @override
  void initState() {
    super.initState();
    loadMovie();
  }


  Future<void> loadMovie() async {
    final String movieId = widget.movieId;

    final movieNotifier = ref.read(movieInfoProvider.notifier);

    await movieNotifier.loadMovie( movieId );

    if( mounted ){
      isLoading = false;
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {

    final moviesData = ref.watch(movieInfoProvider);
    movie = moviesData[widget.movieId];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieId),
      ),
      body: isLoading 
      ? const Center(
        child: CircularProgressIndicator(),
      )
      : Center(
        child: Text(movie!.toString()),
      ),
    );
  }
}