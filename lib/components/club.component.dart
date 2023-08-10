import 'package:cached_network_image/cached_network_image.dart';
import 'package:clapp/models/club.model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ClubComponent extends StatelessWidget {
  const ClubComponent({
    super.key,
    required this.club,
  });
  final Club club;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: club.logo ?? '',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(club.name),
      isThreeLine: true,
      subtitle: Text(
          '${club.membersCount.toString()} miembro(s)\n${club.sport?.name}'),
      trailing: IconButton(
        icon: const Icon(LineAwesomeIcons.chevron_circle_right),
        onPressed: () => context.pushNamed('club', pathParameters: {
          'id': club.id.toString(),
        }),
      ),
    );
  }
}
