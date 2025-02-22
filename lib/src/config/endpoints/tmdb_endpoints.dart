class TmdbEndpoints {

  static const String nowPlaying = '/now_playing';
  static const String popular = '/popular';
  static const String upcoming = '/upcoming';
  static const String topRated = '/top_rated';

  static const String searchMovies = '/movie';

  static String movieCredits(String movieId){
    return '/$movieId/credits';
  }

}