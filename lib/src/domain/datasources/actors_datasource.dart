import 'package:cinemapedia/src/domain/entities/actor.dart';

abstract class ActorsDatasource {

  Future<List<Actor>> getMovieActors({ required String movieId });

}