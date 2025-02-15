import 'package:cinemapedia/src/config/base_urls/tmdb_base_url.dart';
import 'package:cinemapedia/src/config/constants/http_entities.dart';
import 'package:cinemapedia/src/config/constants/http_methods.dart';
import 'package:cinemapedia/src/config/endpoints/tmdb_endpoints.dart';
import 'package:cinemapedia/src/config/environment.dart';
import 'package:cinemapedia/src/domain/datasources/search_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/infrastructure/errors/custom_http_error.dart';
import 'package:cinemapedia/src/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/search_movies_response.dart';
import 'package:dio/dio.dart';


class TmdbSearchDatasource extends SearchDatasource {

  final _dio = Dio(
    BaseOptions(
      baseUrl: TmdbBaseUrl.baseUrlSearch,
      queryParameters: {
        'language': 'es-EC',
        'api_key': Environment.theMovieDBKey,
        'include_adult': false
      }
    )
  );

  @override
  Future<List<Movie>> searchMovies({required String searchText, int page = 1}) async {
    try {
      final response = await _dio.get(
        TmdbEndpoints.searchMovies, 
        queryParameters: {
          'page': page,
          'query': searchText
        }
      );

      final serverResponse = SearchMoviesResponse.fromJson(response.data);
      
      final List<Movie> movieList = serverResponse.results
      .where((e) => e.posterPath != 'no-poster')
      .map((e){
        return MovieMapper.movieDbToEntity(e);
      }).toList();

      return movieList;
    } on DioException catch (e) {
      throw CustomHttpError(
        entity: HttpEntities.movie,
        method: HttpMethods.get,
        datasource: runtimeType.toString(),
        message: e.message ?? '',
        uri: e.requestOptions.uri.toString(),
        bodyData: e.requestOptions.data,
        headers: e.requestOptions.headers
      );      
    } catch (e) {
      throw CustomHttpError(
        entity: HttpEntities.movie,
        method: HttpMethods.get,
        datasource: runtimeType.toString(),
        message: 'Error al consultar la búsqueda de películas'
      );
    }
  }

}