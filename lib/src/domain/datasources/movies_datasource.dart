import 'package:cinemapedia/src/domain/entities/movie.dart';

abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

}