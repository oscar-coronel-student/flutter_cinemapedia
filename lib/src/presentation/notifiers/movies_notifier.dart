import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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