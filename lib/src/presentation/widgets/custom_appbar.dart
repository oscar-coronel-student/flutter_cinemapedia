import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/delegates/search_movies_delegate.dart';
import 'package:cinemapedia/src/presentation/providers/movies/movies_searched_provider.dart';
import 'package:cinemapedia/src/presentation/providers/search/search_query_provider.dart';
import 'package:cinemapedia/src/presentation/screens/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class CustomAppbar extends ConsumerWidget {
  
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final moviesSearched = ref.watch(moviesSearchedProvider);
    final moviesSearchedNotifier = ref.read(moviesSearchedProvider.notifier);

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 0 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon( Icons.movie_outlined, color: colors.primary ),
              const SizedBox( width: 5 ),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  final query = ref.read(searchQueryProvider);

                  final Movie? movieSelected = await showSearch<Movie?>(
                    query: query,
                    context: context,
                    delegate: SearchMoviesDelegate(
                      moviesSearched: moviesSearched,
                      searchMovies: moviesSearchedNotifier.searchMovies,
                    )
                  );

                  await Future.delayed(const Duration( milliseconds: 500 ));
                  if( movieSelected != null && context.mounted ){
                    context.goNamed(
                      MovieScreen.name,
                      pathParameters: {
                        'id': movieSelected.id.toString()
                      }
                    );
                  }
                },
                icon: const Icon( Icons.search )
              )
            ],
          ),
        ),
      )
    );
  }
}