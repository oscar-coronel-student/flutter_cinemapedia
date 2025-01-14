

import 'package:cinemapedia/src/config/constants/constants.dart';

class Url {

  static const String notFound = 'https://m.media-amazon.com/images/I/719dcpoP1QL._AC_UF350,350_QL80_.jpg';

  static String getBackdropUrl(String endpoint){
    return endpoint != ''
      ? '${ Constants.imageUrl }$endpoint'
      : Url.notFound;
  }

  static String getPosterUrl(String endpoint){
    return endpoint != ''
      ? '${ Constants.imageUrl }$endpoint'
      : Url.notFound;
  }

  static String getProfilePath(String endpoint){
    return endpoint != ''
      ? '${ Constants.imageUrl }$endpoint'
      : Url.notFound;
  }

}