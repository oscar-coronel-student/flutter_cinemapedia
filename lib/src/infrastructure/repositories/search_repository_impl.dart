import 'package:cinemapedia/src/domain/datasources/search_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/domain/repositories/search_repository.dart';


class SearchRepositoryImpl implements SearchRepository {
  
  final SearchDatasource _datasource;

  const SearchRepositoryImpl({
    required SearchDatasource datasource
  }):
    _datasource = datasource;
  
  @override
  Future<List<Movie>> searchMovies({required String searchText, int page = 1}) {
    return _datasource.searchMovies(searchText: searchText, page: page);
  }

}