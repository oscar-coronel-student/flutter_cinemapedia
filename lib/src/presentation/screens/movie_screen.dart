import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/presentation/providers/actors_providers.dart';
import 'package:cinemapedia/src/presentation/providers/movie_info_provider.dart';
import 'package:cinemapedia/src/presentation/widgets/gradient_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const String name = 'movie_screen';

  final String movieId;
  final String imageTag;

  const MovieScreen({
    super.key,
    required this.movieId,
    required this.imageTag
  });

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final moviesState = ref.watch(movieInfoProvider);

    final bool hasMovie = moviesState.data.containsKey(widget.movieId);
    final Movie? movie = moviesState.data[widget.movieId];

    return Scaffold(
      body: moviesState.isLoading && !hasMovie
      ? const Center(
        child: CircularProgressIndicator(),
      )
      : _BodyView(movie: movie!, imageTag: widget.imageTag),
    );
  }
}

class _BodyView extends StatelessWidget {
  
  final Movie movie;
  final String imageTag;

  const _BodyView({
    required this.movie,
    required this.imageTag
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar( movie: movie, imageTag: imageTag ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return _MovieDetails(movie: movie);
            }
          )
        )
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;
  final String imageTag;
  
  const _CustomSliverAppBar({ required this.movie, required this.imageTag });

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of( context ).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric( horizontal: 10, vertical: 5 ),
        title: Text(
          movie.title,
          style: const TextStyle( color: Colors.white, fontSize: 20 ),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [

            _PosterPath(movie: movie, imageTag: imageTag),

            GradientBg(
              colors: const [ Colors.transparent, Color.fromRGBO(0, 0, 0, 0.5) ],
              stops: const [ 0.6, 1 ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),

            GradientBg(
              colors: const [ Colors.transparent, Color.fromRGBO(0, 0, 0, 0.8) ],
              stops: const [ 0.8, 1 ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),

          ],
        ),
      ),
    );
  }
}

class _PosterPath extends StatelessWidget {
  
  final Movie movie;
  final String imageTag;

  const _PosterPath({
    required this.movie,
    required this.imageTag
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageTag,
      child: SizedBox.expand(
        child: Image.network(
          movie.posterPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _MovieDetails extends ConsumerWidget {

  final Movie movie;

  const _MovieDetails({ required this.movie });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final actorsByMovieState = ref.watch( actorsByMovieProvider );

    final String actorsError = actorsByMovieState.error;
    final List<Actor> actors = actorsByMovieState.actors;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      movie.posterPath,
                      fit: BoxFit.cover,
                      width: size.width * 0.3,
                    ),
                  ),
              
                  const SizedBox(width: 10),

                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( movie.title, style: textStyles.titleLarge ),
                      Text( movie.overview, textAlign: TextAlign.justify, maxLines: 7, overflow: TextOverflow.ellipsis,),
                    ],
                  )
                 )
              
                ],
              ),
            ),
          ),

          // Géneros de la película
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                ...movie.genreIds.map(( genre ){
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
                      label: Text(genre),
                    ),
                  );
                })
              ],
            ),
          ),

          actorsByMovieState.loading
          ? const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          )
          : (actorsError.isEmpty
            ? Text( actors.length.toString() )
            : Text(actorsError)),

          const SizedBox(height: 100)
      
        ],
      ),
    );
  }
}