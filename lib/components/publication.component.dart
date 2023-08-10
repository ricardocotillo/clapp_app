import 'package:clapp/models/publication.model.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PublicationComponent extends StatelessWidget {
  const PublicationComponent({
    super.key,
    required this.publication,
  });
  final Publication publication;

  @override
  Widget build(BuildContext context) {
    final image = publication.user?.image;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              if (image != null)
                CircleAvatar(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: 36,
                    ),
                  ),
                ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    publication.user?.fullName ?? '',
                    style: AppTheme.headers.headerSm,
                  ),
                  Text(
                    'Hace ${publication.timeSinceCreated}',
                    style: AppTheme.fontSizes.xsStyle,
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(publication.excerpt ?? ''),
        ),
        const SizedBox(
          height: 5.0,
        ),
        if (publication.image != null)
          CachedNetworkImage(
            imageUrl: publication.image!,
            placeholder: (context, url) => Container(
              color: Colors.grey,
              height: 180,
            ),
          ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.heart),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.comment),
            ),
          ],
        ),
      ],
    );
  }
}
