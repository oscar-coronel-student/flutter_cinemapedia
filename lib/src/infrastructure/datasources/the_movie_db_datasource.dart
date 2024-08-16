import 'package:cinemapedia/src/config/environment.dart';
import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
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

    final List<Movie> movies = [];

    response.data;

    return [];
  }

}