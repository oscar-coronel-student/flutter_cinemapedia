import 'package:go_router/go_router.dart';
import 'package:cinemapedia/src/presentation/screens/home_screen.dart';


final appRouter = GoRouter(
  initialLocation: HomeScreen.path,
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.path,
      builder: (context, state) => const HomeScreen(),
    )
  ]
);