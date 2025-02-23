import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/widgets/list_views/actors/movie_simple_slide.dart';
import 'package:flutter/material.dart';

class MovieSimpleListview extends StatelessWidget {

  final List<Movie> movies;

  final void Function(Movie movie)? onTapItem;

  const MovieSimpleListview({
    super.key,
    required this.movies,
    this.onTapItem
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Column(
          children: [
            MovieSimpleSlide(movie: movie, onTap: onTapItem ),
            const Divider( height: 0 )
          ],
        );
      },
    );
  }
}