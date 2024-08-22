import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/src/presentation/providers/movies_providers.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';


final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if( nowPlayingMovies.isEmpty ) return [];

  return nowPlayingMovies.sublist(0, 6);
});