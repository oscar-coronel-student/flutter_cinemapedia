import 'package:cinemapedia/src/domain/entities/movie.dart';


abstract class SearchRepository {

  Future<List<Movie>> searchMovies({ required String searchText, int page = 1 });

}