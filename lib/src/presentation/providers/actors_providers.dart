import 'package:cinemapedia/src/domain/entities/actor.dart';
import 'package:cinemapedia/src/presentation/abstract_classes/provider_dimounted.dart';
import 'package:cinemapedia/src/presentation/providers/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsByMovieProvider = StateNotifierProvider.autoDispose<ActorsByMovieNotifier, ActorsByMovieState>((ref){
  
  final link = ref.keepAlive();
  final getMovieActors = ref.watch( actorsRepositoryProvider ).getMovieActors;

  return ActorsByMovieNotifier(
    link: link,
    getActors: getMovieActors
  );
});


class ActorsByMovieNotifier extends StateNotifier<ActorsByMovieState> implements ProviderDimounted{

  Future<List<Actor>> Function({ required String movieId }) getActors;
  KeepAliveLink link;

  ActorsByMovieNotifier({
    required this.getActors,
    required this.link
  }): super(const ActorsByMovieState());

  Future<void> loadActorsByMovie( String movieId ) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final actors = await getActors(movieId: movieId);

      if(mounted){
        state = state.copyWith(loading: false, actors: actors, error: '');
      }
    } catch (e) {
      if(mounted){
        state = state.copyWith(loading: false, error: e.toString());
      }
    }
  }
  
  @override
  void customDimounted() {
    link.close();
  }
  
}

class ActorsByMovieState {

  final bool loading;
  final List<Actor> actors;
  final String error;

  const ActorsByMovieState({
    this.loading = false,
    this.actors = const [],
    this.error = ''
  });

  ActorsByMovieState copyWith({
    bool? loading,
    List<Actor>? actors,
    String? error
  }) => ActorsByMovieState(
    loading: loading ?? this.loading,
    actors: actors ?? this.actors,
    error: error ?? this.error
  );

}