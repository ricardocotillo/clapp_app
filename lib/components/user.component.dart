import 'package:cached_network_image/cached_network_image.dart';
import 'package:clapp/models/user.model.dart';
import 'package:flutter/material.dart';

class UserComponent extends StatelessWidget {
  const UserComponent({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.image,
            width: 36,
            height: 36,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(user.fullName),
      subtitle: Text(user.email),
    );
  }
}
