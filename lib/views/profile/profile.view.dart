import 'package:clapp/components/carousel.component.dart';
import 'package:clapp/components/comment.component.dart';
import 'package:clapp/components/userCard.component.dart';
import 'package:clapp/models/comment.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/services/auth.service.dart';
import 'package:clapp/services/comment.service.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.user});

  final User user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<User>? _future;
  Future<CommentsPage>? _commentsFuture;
  final AuthService _authService = AuthService();
  final CommentService _commentService = CommentService(
    receiver: CommentType.user,
  );

  @override
  void initState() {
    super.initState();
    _future = _authService.me();
    _commentsFuture = _commentService.list(
        filter: CommentFilter(
      objectId: widget.user.id,
      model: 'user',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FutureBuilder(
            future: _future,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done &&
                  snap.hasData) {
                final User user = snap.data!;
                return UserCardComponent(
                  user: user,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FutureBuilder(
            future: _commentsFuture,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done &&
                  !snap.hasError &&
                  snap.hasData) {
                final CommentsPage page = snap.data!;
                if (page.results.isNotEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 8),
                      CarouselComponent(
                        height: 210,
                        count: page.results.length + 2,
                        gap: 8,
                        builder: (context, i) =>
                            i == 0 || i == page.results.length + 1
                                ? const SizedBox(width: 8)
                                : CommentComponent(
                                    comment: page.results[i - 1],
                                    width: 300,
                                  ),
                      ),
                    ],
                  );
                }
                return const SizedBox(height: 1);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.push('/user/edit'),
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }
}
