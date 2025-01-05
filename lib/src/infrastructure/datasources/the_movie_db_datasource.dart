import 'package:cinemapedia/src/config/base_urls/tmdb_base_url.dart';
import 'package:cinemapedia/src/config/endpoints/tmdb_endpoints.dart';
import 'package:cinemapedia/src/config/environment.dart';
import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/moviedb_details.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/moviedb_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbDatasource implements MoviesDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: TmdbBaseUrl.baseUrlMovie,
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-EC'
    }
  ));

  Future<List<Movie>> _getMovieList({ required String endpoint, int page = 1 }) async {
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

  @override
  Future<List<Movie>> getNowPlaying({ int page = 1 }) async {
    return await _getMovieList(endpoint: TmdbEndpoints.nowPlaying, page: page);    
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await _getMovieList(endpoint: TmdbEndpoints.popular, page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await _getMovieList(endpoint: TmdbEndpoints.topRated, page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await _getMovieList(endpoint: TmdbEndpoints.upcoming, page: page);
  }
  
  @override
  Future<Movie> getMovie({required String movieId}) async {
    final String endpoint = '/$movieId';
    final response = await dio.get(endpoint);

    final movieModel = MoviedbDetails.fromJson(response.data);
    final movieEntity = MovieMapper.movieDbDetailToEntity(movieModel);

    return movieEntity;
  }

}