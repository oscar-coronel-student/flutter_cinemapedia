import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/src/infrastructure/datasources/tmdb_search_datasource.dart';
import 'package:cinemapedia/src/infrastructure/repositories/search_repository_impl.dart';


final searchRepositoryProvider = Provider((ref){
  return SearchRepositoryImpl(
    datasource: TmdbSearchDatasource()
  );
});