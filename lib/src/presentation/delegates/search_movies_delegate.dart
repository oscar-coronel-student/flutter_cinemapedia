import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
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

        return ListView.builder(
          
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return Column(
              children: [
                ListTile(
                  onTap: (){

                  },
                  minTileHeight: 150,
                  leading: SizedBox(
                    width: 100,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        movie.posterPath,
                        fit: BoxFit.cover,
                        height: 150,
                        loadingBuilder: (context, child, loadingProgress) {
                          if( loadingProgress == null ) return child;
                    
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  title: Text(movie.title),
                  subtitle: Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Divider( height: 0 )
              ],
            );
          },
        );
      },
    );
  }

}