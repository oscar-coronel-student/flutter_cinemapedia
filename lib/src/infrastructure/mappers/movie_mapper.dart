import 'package:cinemapedia/src/domain/entities/movie.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/moviedb_movie.dart';

class MovieMapper {

  static Movie movieDbToEntity( MovieDbMovie movieDb ){
    return Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ''
        ? 'https://image.tmdb.org/t/p/w500${ movieDb.backdropPath }'
        : 'https://m.media-amazon.com/images/I/719dcpoP1QL._AC_UF350,350_QL80_.jpg',
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != ''
        ? 'https://image.tmdb.org/t/p/w500${ movieDb.posterPath }'
        : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount
    );
  }

}