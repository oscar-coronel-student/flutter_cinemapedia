import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/widgets/list_views/movies/movie_simple_listview.dart';
import 'package:flutter/material.dart';


typedef SearchMoviesCallback = Future<List<Movie>> Function({ required String searchText });

class SearchMoviesDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMoviesDelegate({
    required this.searchMovies
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
    if( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(seconds: 1), () async {
      if( query.isEmpty ) {
        debounceMovies.add([]);
        return;
      }

      final movies = await searchMovies( searchText: query );
      debounceMovies.add(movies);
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