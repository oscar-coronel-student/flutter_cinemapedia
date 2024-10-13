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
  }

  @override
  Widget build(BuildContext context) {

    final moviesSlideShow = ref.watch( moviesSlideshowProvider );
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: moviesSlideShow),
        MovieHorizontalListview(
          movies: nowPlayingMovies,
          title: 'En Cines',
          subTitle: 'Lunes 20',
          loadNextPage: ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
        ),
        MovieHorizontalListview(
          movies: nowPlayingMovies,
          title: 'En Cines',
          subTitle: 'Lunes 20',
          loadNextPage: ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
        ),

      ],
    );
  }
}