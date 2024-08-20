import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/src/infrastructure/datasources/the_movie_db_datasource.dart';

// Este repositorio es inmutable (solo lectura)
final movieRepositoryProvider = Provider((ref){
  return MovieRepositoryImpl(moviesDatasource: TheMovieDbDatasource());
});