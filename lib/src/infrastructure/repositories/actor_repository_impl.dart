import 'package:cinemapedia/src/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:cinemapedia/src/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl implements ActorsRepository {

  final ActorsDatasource actorsDatasource;

  const ActorRepositoryImpl({
    required this.actorsDatasource
  });

  @override
  Future<List<Actor>> getMovieActors({required String movieId}) {
    return actorsDatasource.getMovieActors(movieId: movieId);
  }

}