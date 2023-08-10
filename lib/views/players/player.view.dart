import 'package:clapp/components/carousel.component.dart';
import 'package:clapp/components/comment.component.dart';
import 'package:clapp/components/userCard.component.dart';
import 'package:clapp/providers/auth.provider.dart';
import 'package:clapp/providers/player.provider.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerProvider playerProvider = Provider.of<PlayerProvider>(context);
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final user = playerProvider.user;
    final comments = playerProvider.commentsPage.results;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (user != null) UserCardComponent(user: user),
              if (comments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Comentarios',
                        style: AppTheme.headers.headerLg,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver Todos'),
                      ),
                    ],
                  ),
                ),
              comments.isNotEmpty
                  ? CarouselComponent(
                      count: comments.length,
                      height: 210,
                      gap: 8,
                      builder: (context, i) => Padding(
                        padding: EdgeInsets.only(
                          left: i == 0 ? 16 : 0,
                          right: i == comments.length - 1 ? 16.0 : 0,
                        ),
                        child: CommentComponent(
                          comment: comments[i],
                          width: 300,
                        ),
                      ),
                    )
                  : Text(
                      'Sin comentarios aun',
                      style: AppTheme.fontSizes.baseStyle.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
              const SizedBox(height: 16),
              if (user != null && authProvider.user?.id != user.id)
                MaterialButton(
                  onPressed: () => playerProvider.openCommentDialog(
                      context, authProvider.user!),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: const Text('Dejar Comentario'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
