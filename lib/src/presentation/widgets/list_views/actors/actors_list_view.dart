import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:cinemapedia/src/presentation/widgets/list_view_items/actor_slide.dart';
import 'package:flutter/material.dart';

class ActorsListView extends StatelessWidget {

  final List<Actor> actors;

  const ActorsListView({
    super.key,
    required this.actors
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return ActorSlide(actor: actor);
        },
      ),
    );
  }
}