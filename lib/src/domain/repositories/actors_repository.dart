import 'package:cinemapedia/src/domain/entities/actor.dart';

abstract class ActorsRepository {

  Future<List<Actor>> getMovieActors({ required String movieId });

}