import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref){

  final getMovie = ref.watch( movieRepositoryProvider ).getMovie;

  return MovieMapNotifier(
    getMovie: getMovie
  );
});


typedef GetMovieCallback = Future<Movie> Function({required String movieId});


class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie
  }): super({});

  Future<void> loadMovie( String movieId ) async {
    final bool existMovie = state.containsKey(movieId);
    if(!existMovie){
      final Movie movie = await getMovie( movieId: movieId );
      state = {
        ...state,
        '${ movie.id }': movie
      };
    }
  }

}