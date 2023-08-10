import 'package:cached_network_image/cached_network_image.dart';
import 'package:clapp/models/comment.model.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';

class CommentComponent extends StatelessWidget {
  const CommentComponent({super.key, required this.comment, this.width});
  final Comment comment;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              comment.message.length < 200
                  ? comment.message
                  : '${comment.message.substring(0, 200)}...',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: comment.owner.image,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.owner.fullName,
                    style: AppTheme.headers.headerSm,
                  ),
                  Text(comment.timeSinceCreated != null
                      ? 'Hace ${comment.timeSinceCreated}'
                      : ''),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
