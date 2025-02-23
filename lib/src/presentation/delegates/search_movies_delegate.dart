import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/widgets/list_views/movies/movie_simple_listview.dart';
import 'package:flutter/material.dart';


typedef SearchMoviesCallback = Future<List<Movie>> Function({ required String searchText });

class SearchMoviesDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;

  SearchMoviesDelegate({
    required this.searchMovies
  }): super(searchFieldLabel: 'Buscar películas');


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
    return FutureBuilder(
      future: searchMovies( searchText: query ),
      builder: (context, snapshot){
        if( snapshot.connectionState != ConnectionState.done ){
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