import 'package:cinemapedia/src/config/helpers/url.dart';
import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:cinemapedia/src/infrastructure/models/movidb/movie_credits_response.dart';

class ActorMapper {

  static List<Actor> getActorsFromMovieCreditsModel(MovieCreditsResponse movieCredits) {

    return movieCredits.cast.map(( actor ){
      return Actor(
        id: actor.id,
        name: actor.name,
        profilePath: Url.getProfilePath(actor.profilePath ?? ''),
        character: actor.character,
      );
    }).toList();
  }

}