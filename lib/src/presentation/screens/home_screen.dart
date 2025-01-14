import 'package:cinemapedia/src/presentation/providers/initial_loading_provider.dart';
import 'package:cinemapedia/src/presentation/widgets/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/presentation/providers/movies_providers.dart';
import 'package:cinemapedia/src/presentation/providers/movies_slideshow_provider.dart';
import 'package:cinemapedia/src/presentation/widgets/custom_appbar.dart';
import 'package:cinemapedia/src/presentation/widgets/custom_bottom_navigationbar.dart';
import 'package:cinemapedia/src/presentation/widgets/movie_horizontal_listview.dart';
import 'package:cinemapedia/src/presentation/widgets/movies_slideshow.dart';

class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';
  static const String path = '/home';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  
  const _HomeView();

  @override
  ConsumerState<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final moviesSlideShow = ref.watch( moviesSlideshowProvider );
    
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );
    final upcomingMovies = ref.watch( upcomingMoviesProvider );

    final isFirstLoading = ref.watch(initialLoadingProvider);

    if(isFirstLoading) return const FullScreenLoader();

    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          title: CustomAppbar(),
        ),

        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: moviesSlideShow),
                
                MovieHorizontalListview(
                  identifier: 'en_cines',
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
                ),
                
                MovieHorizontalListview(
                  identifier: 'proximamente',
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subTitle: 'En este mes',
                  loadNextPage: ref.read(upcomingMoviesProvider.notifier).loadNextPage,
                ),

                MovieHorizontalListview(
                  identifier: 'populares',
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: ref.read(popularMoviesProvider.notifier).loadNextPage,
                ),
                
                MovieHorizontalListview(
                  identifier: 'mejores_calificadas',
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'Desde siempre',
                  loadNextPage: ref.read(topRatedMoviesProvider.notifier).loadNextPage,
                ),

                const SizedBox( height: 10 )
            
              ],
            );
          },
          childCount: 1
        ))

      ],
    );
  }
}