import 'package:cached_network_image/cached_network_image.dart';
import 'package:clapp/components/carousel.component.dart';
import 'package:clapp/components/comment.component.dart';
import 'package:clapp/providers/auth.provider.dart';
import 'package:clapp/providers/club.provider.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ClubView extends StatelessWidget {
  const ClubView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final ClubProvider clubProvider = Provider.of<ClubProvider>(context);
    final club = clubProvider.club;
    final logo = club.logo;
    final members = clubProvider.membershipsPage.results;
    final comments = clubProvider.commentsPage.results;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(club.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (logo != null && logo.isNotEmpty)
              CachedNetworkImage(
                imageUrl: logo,
                width: size.width,
                height: 300,
                fit: BoxFit.cover,
              ),
            if (members.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Miembros',
                      style: AppTheme.headers.headerBase,
                    ),
                    TextButton(
                        onPressed: () => context.pushNamed(
                              'clubPlayers',
                              pathParameters: {
                                'id': club.id.toString(),
                              },
                            ),
                        child: const Text('Ver Todos'))
                  ],
                ),
              ),
            if (members.isNotEmpty)
              CarouselComponent(
                count: members.length,
                height: 150,
                gap: 24.0,
                builder: (context, i) => Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 16 : 0,
                    right: i == members.length - 1 ? 16.0 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => context.pushNamed(
                      'player',
                      pathParameters: {
                        'id': members[i].user.id.toString(),
                      },
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: members[i].user.image,
                              width: 70,
                            ),
                          ),
                        ),
                        Text(
                          members[i].user.fullName,
                          style: AppTheme.headers.headerSm,
                        ),
                        if (members[i].role == 'owner')
                          Text(
                            members[i].localizedRole,
                            style: AppTheme.fontSizes.xsStyle,
                          ),
                        if (members[i].team)
                          Text(
                            'Jugador',
                            style: AppTheme.fontSizes.xsStyle,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            if (comments.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comentarios',
                      style: AppTheme.headers.headerBase,
                    ),
                    TextButton(onPressed: () {}, child: const Text('Ver Todos'))
                  ],
                ),
              ),
            if (comments.isNotEmpty)
              CarouselComponent(
                count: comments.length,
                height: 210,
                builder: (context, i) => Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 16.0 : 0,
                    right: i == comments.length - 1 ? 16.0 : 0,
                  ),
                  child: CommentComponent(
                    comment: comments[i],
                  ),
                ),
              ),
            const SizedBox(height: 16.0),
            MaterialButton(
              onPressed: () =>
                  clubProvider.openCommentDialog(context, authProvider.user!),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: const Text('Dejar Comentario'),
            )
          ],
        ),
      ),
    );
  }
}
