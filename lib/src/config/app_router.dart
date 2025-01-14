import 'package:cinemapedia/src/presentation/screens/movie_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/src/presentation/screens/home_screen.dart';


final appRouter = GoRouter(
  initialLocation: HomeScreen.path,
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.path,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: MovieScreen.name,
          path: 'movie/:id/:image_tag',
          builder: (context, state) {
            final String movieId = state.pathParameters['id'] ?? 'no-id';
            final String imageTag = state.pathParameters['image_tag'] ?? DateTime.now().toIso8601String();
            return MovieScreen(movieId: movieId, imageTag: imageTag);
          },
        ),
      ]
    ),
  ]
);