import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/search/search_query_provider.dart';
import 'package:cinemapedia/src/presentation/providers/search_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


typedef SearchMoviesCallback = Future<List<Movie>> Function({ required String searchText, int page });

final moviesSearchedProvider = StateNotifierProvider<MoviesSearchedNotifier, List<Movie>>((ref){
  final searchRepository = ref.read( searchRepositoryProvider );

  return MoviesSearchedNotifier(
    search: searchRepository.searchMovies,
    onSearched: ({required query}) {
      ref.read(searchQueryProvider.notifier).update((state) => query);
    },
  );
});


class MoviesSearchedNotifier extends StateNotifier<List<Movie>> {
  
  final SearchMoviesCallback _search;
  final void Function({ required String query}) _onSearched;

  MoviesSearchedNotifier({
    required SearchMoviesCallback search,
    required void Function({ required String query}) onSearched
  }):
    _search = search,
    _onSearched = onSearched,
    super( const [] );

  Future<List<Movie>> searchMovies({ required String searchText, int page = 1 }) async {
    final moviesSearched = await _search(searchText: searchText);
    _onSearched( query: searchText );
    state = moviesSearched;
    return moviesSearched;
  }

}