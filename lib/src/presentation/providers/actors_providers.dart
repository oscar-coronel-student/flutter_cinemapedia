import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:cinemapedia/src/presentation/abstract_classes/provider_dimounted.dart';
import 'package:cinemapedia/src/presentation/providers/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider.autoDispose<ActorsByMovieNotifier, Map<String, ActorsByMovie>>((ref){
  
  final link = ref.keepAlive();
  final getMovieActors = ref.watch( actorsRepositoryProvider ).getMovieActors;

  return ActorsByMovieNotifier(
    link: link,
    getActors: getMovieActors
  );
});

typedef GetActors = Future<List<Actor>> Function({ required String movieId });

class ActorsByMovieNotifier extends StateNotifier<Map<String, ActorsByMovie>> implements ProviderDimounted{

  bool isGeneralLoading = false;

  final GetActors _getActors;
  final KeepAliveLink _link;

  ActorsByMovieNotifier({
    required GetActors getActors,
    required KeepAliveLink link
  }):
  _getActors = getActors,
  _link = link,
  super({});

  Future<void> loadActorsByMovie( String movieId ) async {
    final bool hasActors = state.containsKey(movieId);
    final ActorsByMovie? currentActors = state[movieId];
    if( isGeneralLoading || (hasActors && currentActors?.error.isEmpty == true ) ) return;

    isGeneralLoading = true;
    state = { ...state, movieId: const ActorsByMovie( loading: true ) };
    final actorsByMovie = state[movieId]!;

    try {
      final actors = await _getActors(movieId: movieId);

      if( mounted ){
        state = { 
          ...state,
          movieId: actorsByMovie.copyWith( loading: false, actors: actors, error: '' )
        };
      }
    } catch (e) {
      if(mounted){
        state = { 
          ...state,
          movieId: actorsByMovie.copyWith( loading: false, actors: [], error: e.toString() )
        };
      }
    } finally {
      isGeneralLoading = false;
    }
  }
  
  @override
  void customDimounted() {
    _link.close();
  }
  
}

class ActorsByMovie {

  final bool loading;
  final List<Actor> actors;
  final String error;

  const ActorsByMovie({
    this.loading = false,
    this.actors = const [],
    this.error = ''
  });

  ActorsByMovie copyWith({
    bool? loading,
    List<Actor>? actors,
    String? error
  }) => ActorsByMovie(
    loading: loading ?? this.loading,
    actors: actors ?? this.actors,
    error: error ?? this.error
  );

}