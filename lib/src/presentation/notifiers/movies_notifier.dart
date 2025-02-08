import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/infrastructure/errors/custom_http_error.dart';
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

    try {
      final List<Movie> movies = await fetchMoreMovies( page: currentPage );
      state = [ ...state, ...movies ];
      await Future.delayed(const Duration( seconds: 1 ));
    } on CustomHttpError catch (e) {
      print(e.toString());
      currentPage--;
    } finally {
      isLoading = false;
    }
  }

}