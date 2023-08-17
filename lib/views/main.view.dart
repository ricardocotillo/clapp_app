import 'package:cached_network_image/cached_network_image.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/providers/auth.provider.dart';
import 'package:clapp/providers/clubs.provider.dart';
import 'package:clapp/providers/home.provider.dart';
import 'package:clapp/providers/main.provider.dart';
import 'package:clapp/providers/places.provider.dart';
import 'package:clapp/theme.dart';
import 'package:clapp/views/clubs/clubs.view.dart';
import 'package:clapp/views/home.view.dart';
import 'package:clapp/views/places/places.view.dart';
import 'package:clapp/views/profile/profile.view.dart';
import 'package:clapp/views/store.view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final HomeProvider homeProvider = HomeProvider();
  List<Widget> _tabs(User? user) {
    return <Widget>[
      const HomeView(),
      if (user != null)
        ProfileView(
          user: user,
        ),
      const ClubsView(),
      ChangeNotifierProvider(
        create: (_) => PlacesProvider(),
        child: const PlacesView(),
      ),
      const StoreView(),
    ];
  }

  PreferredSizeWidget? _appBar({
    required int index,
    required User? user,
    required VoidCallback onPublish,
  }) {
    switch (index) {
      case 0:
        final image = user?.image;
        return AppBar(
          leading: image != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: image,
                        width: 36,
                      ),
                    ),
                  ),
                )
              : null,
          title: Text(
            user?.fullName ?? '',
            style: AppTheme.headers.headerSm,
          ),
          elevation: 2,
          leadingWidth: 52,
          actions: [
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: onPublish,
              icon: const Icon(LineAwesomeIcons.edit),
            )
          ],
        );
      case 2:
        return AppBar(
          title: const Text('Mis Clubes'),
          actions: [
            TextButton.icon(
              onPressed: () => context.pushNamed('clubs'),
              icon: const Icon(
                LineAwesomeIcons.search,
                size: 16.0,
              ),
              label: const Text('Busca más'),
            ),
          ],
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context);
    final AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    final HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    final ClubsProvider clubsProvider = Provider.of<ClubsProvider>(context);
    final user = authProvider.user;
    return Scaffold(
      appBar: _appBar(
        index: mainProvider.currentIndex,
        user: user,
        onPublish: () => homeProvider.publish(context),
      ),
      body: _tabs(user)[mainProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: mainProvider.setTab,
        currentIndex: mainProvider.currentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.home),
            label: 'Inicio',
          ),
          if (user != null)
            const BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.user),
              label: 'Perfil',
            ),
          const BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.users),
            label: 'Equipos',
          ),
          const BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.map_marker),
            label: 'Canchas',
          ),
          const BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.store),
            label: 'Tienda',
          ),
        ],
      ),
      floatingActionButton:
          clubsProvider.clubs.isNotEmpty && mainProvider.currentIndex == 2
              ? FloatingActionButton(
                  onPressed: () => clubsProvider.openForm(context),
                  child: const Icon(LineAwesomeIcons.plus),
                )
              : null,
    );
  }
}
