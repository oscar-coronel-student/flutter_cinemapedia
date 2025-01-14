import 'package:cinemapedia/src/domain/repositories/actors_repository.dart';
import 'package:cinemapedia/src/infrastructure/datasources/tmdb_actors_datasource.dart';
import 'package:cinemapedia/src/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsRepositoryProvider = Provider((ref){
  ActorsRepository repository = ActorRepositoryImpl(actorsDatasource: TmdbActorsDatasource());
  return repository;
});