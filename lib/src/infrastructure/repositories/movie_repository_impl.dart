import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl implements MoviesRepository {

  final MoviesDatasource moviesDatasource;

  const MovieRepositoryImpl({
    required this.moviesDatasource
  });
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDatasource.getNowPlaying(page: page);
  }

}