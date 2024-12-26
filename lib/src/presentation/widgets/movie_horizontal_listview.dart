import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/config/helpers/human_formats.dart';
import 'package:cinemapedia/src/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final Future<void> Function()? loadNextPage;


  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final ScrollController scrollController = ScrollController();
  bool isLoadingNextPage = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener((){
      if( scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent ){
        if( !isLoadingNextPage && widget.loadNextPage != null ){
          loadNextPage();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> loadNextPage() async {
    isLoadingNextPage = true;
    setState(() {});

    widget.loadNextPage!();

    if( mounted ){
      isLoadingNextPage = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if( widget.title != null || widget.subTitle != null )
            _Title( title: widget.title, subTitle: widget.subTitle ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];

                return FadeInRight(
                  child: _Slide(movie: movie)
                );
              },
            )
          )

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  
  final Movie movie;

  const _Slide({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 8 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Esto es la imagen
          SizedBox(
            width: 150,
            height: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if( loadingProgress == null ){
                    return GestureDetector(
                      onTap: (){
                        context.go('${ HomeScreen.path }/movie/${ movie.id }');
                      },
                      child: FadeIn(child: child)
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator( strokeWidth: 2 )
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox( height: 5 ),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox( width: 3 ),
                Text('${movie.voteAverage}', style: textStyle.bodyMedium?.copyWith( color: Colors.yellow.shade800 )),
                const Spacer(),
                Text(HumanFormats.format( movie.popularity ), style: textStyle.bodySmall,)
              ],
            ),
          )

        ],
      )
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const _Title({
    this.title,
    this.subTitle
  });

  @override
  Widget build(BuildContext context) {

    final titleTheme = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only( top: 10 ),
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Row(
        children: [
          if(title != null)
              Text(title!, style: titleTheme),

          const Spacer(), // Flex

          if( subTitle != null )
            FilledButton.tonal(
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact
              ),
              onPressed: (){}, 
              child: Text(subTitle!)
            )

        ],
      ),
    );
  }
}