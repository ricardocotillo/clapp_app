import 'package:clapp/components/commentForm.component.dart';
import 'package:clapp/models/comment.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/services/comment.service.dart';
import 'package:clapp/services/user.service.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  User? user;
  CommentsPage commentsPage = CommentsPage();
  final UserService _userService = UserService();
  final CommentService _commentService = CommentService(
    receiver: CommentType.user,
  );

  PlayerProvider({required int id}) {
    Future.wait([
      _userService.get(id),
      _commentService.list(
        filter: Filter(params: {'object_id': id, 'nodel': 'user'}),
      ),
    ]).then((values) {
      user = values[0] as User;
      commentsPage = values[1] as CommentsPage;
      notifyListeners();
    });
  }

  openCommentDialog(BuildContext context, User user) async {
    final message = await showDialog<String?>(
      context: context,
      builder: (context) => CommentFormComponent(
        title: Text(
          'Comenta algo sobre ${user.firstName}',
          style: AppTheme.headers.headerBase,
        ),
      ),
    );
    final id = user.id;
    if (message != null && id != null) {
      var comment = Comment(owner: user, objectId: id, message: message);
      comment = await _commentService.create(comment);
      commentsPage.results.insert(0, comment);
      notifyListeners();
    }
  }
}
