import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/movies_repository_provider.dart';


final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){
  
  final getNowPlaying = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier( fetchMoreMovies: getNowPlaying );
});


typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies( page: currentPage );
    state = [ ...state, ...movies ];
    
    await Future.delayed(const Duration( seconds: 1 ));
    isLoading = false;
  }

}