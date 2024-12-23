import 'package:cinemapedia/src/presentation/notifiers/movies_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/movies_repository_provider.dart';


final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){
  final getNowPlaying = ref.watch( movieRepositoryProvider ).getNowPlaying;
  return MoviesNotifier( fetchMoreMovies: getNowPlaying );
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>( (ref) {
  final getPopular = ref.watch( movieRepositoryProvider ).getPopular;
  return MoviesNotifier(fetchMoreMovies: getPopular); 
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>( (ref) {
  final getTopRated = ref.watch( movieRepositoryProvider ).getTopRated;
  return MoviesNotifier(fetchMoreMovies: getTopRated); 
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>( (ref) {
  final getUpcoming = ref.watch( movieRepositoryProvider ).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: getUpcoming); 
});