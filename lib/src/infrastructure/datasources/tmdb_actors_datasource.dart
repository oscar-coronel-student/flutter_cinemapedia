import 'package:cinemapedia/src/config/base_urls/tmdb_base_url.dart';
import 'package:cinemapedia/src/config/endpoints/tmdb_endpoints.dart';
import 'package:cinemapedia/src/config/environment.dart';
import 'package:cinemapedia/src/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:cinemapedia/src/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/movie_credits_response.dart';
import 'package:dio/dio.dart';

class TmdbActorsDatasource implements ActorsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: TmdbBaseUrl.baseUrlMovie,
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-EC'
    }
  ));

  @override
  Future<List<Actor>> getMovieActors({required String movieId}) async {
    final response = await dio.get(TmdbEndpoints.movieCredits(movieId));

    final movieCredits = MovieCreditsResponse.fromJson(response.data);
    final actors = ActorMapper.getActorsFromMovieCreditsModel(movieCredits);

    return actors;
  }

}