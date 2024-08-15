import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static final String theMovieDBKey = dotenv.env['THE_MOVIEDB_KEY'] ?? '';

}