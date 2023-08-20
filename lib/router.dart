import 'package:clapp/providers/auth.provider.dart';
import 'package:clapp/providers/book.provider.dart';
import 'package:clapp/providers/club.provider.dart';
import 'package:clapp/providers/allClubs.provider.dart';
import 'package:clapp/providers/login.provider.dart';
import 'package:clapp/providers/main.provider.dart';
import 'package:clapp/providers/place.provider.dart';
import 'package:clapp/providers/player.provider.dart';
import 'package:clapp/providers/players.provider.dart';
import 'package:clapp/providers/profile.provider.dart';
import 'package:clapp/providers/register.provider.dart';
import 'package:clapp/views/clubs/allClubs.view.dart';
import 'package:clapp/views/clubs/club.view.dart';
import 'package:clapp/views/main.view.dart';
import 'package:clapp/views/auth/login.view.dart';
import 'package:clapp/views/places/book.view.dart';
import 'package:clapp/views/places/place.view.dart';
import 'package:clapp/views/players/player.view.dart';
import 'package:clapp/views/players/players.view.dart';
import 'package:clapp/views/profile/editProfile.view.dart';
import 'package:clapp/views/auth/register.view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  refreshListenable: AuthProvider(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => MainProvider(),
        child: const MainView(),
      ),
      redirect: (context, state) {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        if (!auth.isAuthenticated &&
            !['/login', '/register'].contains(state.matchedLocation)) {
          return '/login';
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (context, state) => const MainView(),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginView(),
          ),
        ),
        GoRoute(
          path: 'register',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => RegisterProvider(),
            child: const RegisterView(),
          ),
        ),
        GoRoute(
          path: 'place/:id',
          name: 'place',
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (_) => PlaceProvider(
                id: int.parse(state.pathParameters.values.first),
              ),
              child: const PlaceView(),
            );
          },
        ),
        GoRoute(
          path: 'book/:id',
          name: 'book',
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (_) => BookProvider(
                userId:
                    Provider.of<AuthProvider>(context, listen: false).user?.id,
                courtId: int.parse(state.pathParameters.values.first),
              ),
              child: const BookView(),
            );
          },
        ),
        GoRoute(
          path: 'user/edit',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => ProfileProvider(),
            child: const EditProfileView(),
          ),
        ),
        GoRoute(
          path: 'clubs',
          name: 'clubs',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => AllClubsProvider(),
            child: const AllClubsView(),
          ),
          routes: [
            GoRoute(
              path: ':id',
              name: 'club',
              builder: (context, state) => ChangeNotifierProvider(
                create: (_) => ClubProvider(
                  id: int.parse(state.pathParameters.values.first),
                ),
                child: const ClubView(),
              ),
            ),
            GoRoute(
              path: ':id/players',
              name: 'clubPlayers',
              builder: (context, state) => Provider(
                create: (_) => PlayersProvider(
                  clubId: int.parse(state.pathParameters.values.first),
                ),
                child: const PlayersView(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'players/:id',
          name: 'player',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => PlayerProvider(
              id: int.parse(state.pathParameters.values.first),
            ),
            child: const PlayerView(),
          ),
        ),
      ],
    ),
  ],
);
