

class Url {

  static const String notFound = 'https://m.media-amazon.com/images/I/719dcpoP1QL._AC_UF350,350_QL80_.jpg';

  static String getBackdropUrl(String endpoint){
    return endpoint != ''
      ? 'https://image.tmdb.org/t/p/w500$endpoint'
      : Url.notFound;
  }

  static String getPosterUrl(String endpoint){
    return endpoint != ''
      ? 'https://image.tmdb.org/t/p/w500$endpoint'
      : Url.notFound;
  }

}