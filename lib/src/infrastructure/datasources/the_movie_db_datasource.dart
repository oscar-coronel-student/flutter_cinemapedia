import 'package:cinemapedia/src/config/environment.dart';
import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/moviedb_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbDatasource implements MoviesDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-EC'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({ int page = 1 }) async {
    const String endpoint = '/movie/now_playing';

    final response = await dio.get(
      endpoint, 
      queryParameters: {
        'page': page
      }
    );

    final serverResponse = MovieDbResponse.fromJson(response.data);
    
    final List<Movie> movieList = serverResponse.results
    .where((e) => e.posterPath != 'no-poster')
    .map((e){
      return MovieMapper.movieDbToEntity(e);
    }).toList();

    return movieList;
  }

}