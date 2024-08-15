import 'package:cinemapedia/src/domain/entities/movie.dart';

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

}