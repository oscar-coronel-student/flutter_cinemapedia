import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, MovieInfoState>((ref){

  final getMovie = ref.watch( movieRepositoryProvider ).getMovie;

  return MovieMapNotifier(
    getMovie: getMovie
  );
});


typedef GetMovieCallback = Future<Movie> Function({required String movieId});


class MovieMapNotifier extends StateNotifier<MovieInfoState> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie
  }): super(MovieInfoState());

  Future<void> loadMovie( String movieId ) async {
    final bool existMovie = state.data.containsKey(movieId);
    if(!existMovie){
      state = state.copyWith(isLoading: true);
      final Movie movie = await getMovie( movieId: movieId );
      state = state.copyWith(isLoading: false, data: {
        ...state.data,
        '${ movie.id }': movie
      });
    }
  }

}

class MovieInfoState {

  final bool isLoading;
  final Map<String, Movie> data;

  MovieInfoState({
    this.isLoading = false,
    this.data = const {}
  });

  MovieInfoState copyWith({
    bool? isLoading,
    Map<String, Movie>? data
  }) => MovieInfoState(
    isLoading: isLoading ?? this.isLoading,
    data: data ?? this.data
  );

}