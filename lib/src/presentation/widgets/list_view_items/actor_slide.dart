import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:flutter/material.dart';

class ActorSlide extends StatelessWidget {

  final Actor actor;

  const ActorSlide({
    super.key,
    required this.actor,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration( milliseconds: 700 ),
      child: Container(
        margin: const EdgeInsets.only( left: 10 ),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Fotografía de Actor */
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                actor.profilePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if( loadingProgress == null ) return child;
              
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator())
                  ); 
                },
              ),
            ),
      
            const SizedBox( height: 7 ),
      
            /* Nombre de Actor */
            Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle( 
                fontWeight: FontWeight.w600,
              ),
            ),
      
            /* Character */
            Text(
              actor.character ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle( 
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            )
          ],
        )
      ),
    );
  }
}