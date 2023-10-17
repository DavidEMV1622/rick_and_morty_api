import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_api/screens/characters_screen.dart';
import 'package:rick_and_morty_api/screens/home_screen.dart';

import '../models/character_model.dart';
import '../splashScreen/splash.dart';


/* final GoRouter appRouter = GoRouter( 
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const HomeScreen();
      },

      routes: [
        GoRoute(
          path: "character",
          builder: (context, state) {
            final character = state.extra as Character;
            return CharactersScreen(
              character: character,
            );
          },
        )
      ]
    )
  ],
); */

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const HomeScreen();
      },
    ),

    GoRoute(
      path: "/character",
      builder: (context, state) {
        final character = state.extra as Character;
        return CharactersScreen(
          character: character,
        );
      },
    ),
  ]
);
