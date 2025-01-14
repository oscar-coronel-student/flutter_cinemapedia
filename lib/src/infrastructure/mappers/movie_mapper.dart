import 'package:cinemapedia/src/config/helpers/url.dart';
import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/moviedb_details.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/moviedb_movie.dart';

class MovieMapper {

  static Movie movieDbToEntity( MovieDbMovie movieDb ){
    return Movie(
      adult: movieDb.adult,
      backdropPath: Url.getBackdropUrl(movieDb.backdropPath),
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: Url.getPosterUrl(movieDb.posterPath),
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount
    );
  }

  static Movie movieDbDetailToEntity( MoviedbDetails movieDetail ){
    return Movie(
      adult: movieDetail.adult,
      backdropPath: Url.getBackdropUrl(movieDetail.backdropPath),
      genreIds: movieDetail.genres.map((e) => e.name.toString()).toList(),
      id: movieDetail.id,
      originalLanguage: movieDetail.originalLanguage,
      originalTitle: movieDetail.originalTitle,
      overview: movieDetail.overview,
      popularity: movieDetail.popularity,
      posterPath: Url.getPosterUrl(movieDetail.posterPath),
      releaseDate: movieDetail.releaseDate,
      title: movieDetail.title,
      video: movieDetail.video,
      voteAverage: movieDetail.voteAverage,
      voteCount: movieDetail.voteCount
    );
  }

}