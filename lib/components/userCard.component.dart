import 'package:cached_network_image/cached_network_image.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserCardComponent extends StatelessWidget {
  const UserCardComponent({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final image = user.image;
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null)
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              Text(
                user.fullName,
                style: AppTheme.headers.headerBase,
              ),
              Text(user.email),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.rating?.toStringAsFixed(1) ?? '--',
                    style: AppTheme.headers.headerXl,
                  ),
                  const Icon(
                    LineAwesomeIcons.star_1,
                    size: 30.0,
                  )
                ],
              ),
              Text(
                'Calificación',
                style: AppTheme.fontSizes.xsStyle,
              ),
              const SizedBox(
                width: 100,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.matchesAssisted > 0
                        ? user.matchesAssisted.toString()
                        : '--',
                    style: AppTheme.headers.headerXl,
                  ),
                  const Icon(
                    LineAwesomeIcons.star_1,
                    size: 30.0,
                  )
                ],
              ),
              Text(
                'Partidos asistidos',
                style: AppTheme.fontSizes.xsStyle,
              ),
              const SizedBox(
                width: 100,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.matchesAbandoned > 0
                        ? user.matchesAbandoned.toString()
                        : '--',
                    style: AppTheme.headers.headerXl,
                  ),
                  const Icon(
                    LineAwesomeIcons.star_1,
                    size: 30.0,
                  )
                ],
              ),
              Text(
                'Partidos abandonados',
                style: AppTheme.fontSizes.xsStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
