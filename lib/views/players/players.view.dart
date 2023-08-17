import 'package:cached_network_image/cached_network_image.dart';
import 'package:clapp/models/membership.model.dart';
import 'package:clapp/providers/players.provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayersView extends StatefulWidget {
  const PlayersView({super.key});

  @override
  State<PlayersView> createState() => _PlayersViewState();
}

class _PlayersViewState extends State<PlayersView> {
  @override
  Widget build(BuildContext context) {
    final PlayersProvider playersProvider =
        Provider.of<PlayersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miembros'),
        actions: [
          IconButton(
            onPressed: () => playersProvider.openForm(context),
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(LineAwesomeIcons.plus),
          )
        ],
      ),
      body: SafeArea(
        child: PagedListView(
          pagingController: playersProvider.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Membership>(
            itemBuilder: (context, member, i) => ListTile(
              leading: member.user.image != null
                  ? CircleAvatar(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: member.user.image!,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : null,
              title: Text(member.user.fullName),
              subtitle: Text(member.role),
              trailing: IconButton(
                onPressed: () => context.pushNamed(
                  'player',
                  pathParameters: {
                    'id': member.user.id.toString(),
                  },
                ),
                icon: const Icon(LineAwesomeIcons.chevron_circle_right),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
