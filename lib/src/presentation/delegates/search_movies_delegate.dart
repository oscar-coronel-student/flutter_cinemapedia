import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/movies/movies_searched_provider.dart';
import 'package:cinemapedia/src/presentation/widgets/list_views/movies/movie_simple_listview.dart';
import 'package:flutter/material.dart';

class SearchMoviesDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  final List<Movie> moviesSearched;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast( sync: true );
  Timer? _debounceTimer;
  bool isFirstQueryChange = true;

  SearchMoviesDelegate({
    required this.searchMovies,
    this.moviesSearched = const []
  }): super(searchFieldLabel: 'Buscar películas');
  

  @override
  void close(BuildContext context, Movie? result) {
    clearStreams();
    super.close(context, result);
  }

  void clearStreams(){
    debounceMovies.close();
  }

  void _onQueryChanged(String query){
    if(isFirstQueryChange){
      isFirstQueryChange = false;
      return;
    }

    if( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(seconds: 1), () async {
      final movies = await searchMovies( searchText: query );
      if( !debounceMovies.isClosed ){
        debounceMovies.add(movies);
      }
    });
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.trim().isNotEmpty 
        ? FadeIn(
            animate: true,
            duration: const Duration( milliseconds: 300 ),
            child: IconButton(
              onPressed: (){
                query = '';
              },
              icon: const Icon( Icons.clear_outlined )
            ),
          )
        : Container()
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: const Icon( Icons.arrow_back_rounded )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    _onQueryChanged( query );
    
    return StreamBuilder(
      stream: debounceMovies.stream,
      initialData: moviesSearched,
      builder: (context, snapshot){
        if( !snapshot.hasData ){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<Movie> movies = snapshot.data ?? []; 

        return MovieSimpleListview(
          movies: movies,
          onTapItem: (movie) {
            close(context, movie);
          },
        );
      },
    );
  }

}