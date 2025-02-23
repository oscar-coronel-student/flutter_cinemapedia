import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/config/helpers/human_formats.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieSimpleSlide extends StatelessWidget {
  
  final Movie movie;

  final void Function(Movie movie)? onTap;

  const MovieSimpleSlide({
    super.key,
    required this.movie,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: (){
        if(onTap != null){
          onTap!(movie);
        }
      },
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              /* Image */
              SizedBox(
                width: 80,
                height: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if( loadingProgress == null ) {
                        return FadeIn(child: child);
                      }
                
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
          
              /* Title */
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 10 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox( height: 2 ),

                      Text( 
                        movie.overview,
                        style: textTheme.labelMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),

                      const SizedBox( height: 5 ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon( 
                            Icons.star_half_rounded,
                            size: 20,
                            color: Colors.yellow.shade800,
                          ),
                          const SizedBox( width: 4 ),
                          Text( 
                            HumanFormats.format(movie.voteAverage, 1),
                            style: textTheme.bodyMedium?.copyWith( color: Colors.yellow.shade800 )
                          )
                        ],
                      )
                    ],
                  ),
                )
              )
          
            ],
          )
        ),
      ),
    );
  }
}