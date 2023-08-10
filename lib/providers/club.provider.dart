import 'package:clapp/components/commentForm.component.dart';
import 'package:clapp/models/club.model.dart';
import 'package:clapp/models/comment.model.dart';
import 'package:clapp/models/membership.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/services/club.service.dart';
import 'package:clapp/services/comment.service.dart';
import 'package:clapp/services/membership.service.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';

class ClubProvider extends ChangeNotifier {
  final ClubService _clubService = ClubService();
  final CommentService _commentService = CommentService(
    receiver: CommentType.club,
  );
  final MembershipService _membershipService = MembershipService();

  Club club = Club(name: '', logo: '');
  MembershipsPage membershipsPage = MembershipsPage();
  CommentsPage commentsPage = CommentsPage();

  ClubProvider({required int id}) {
    Future.wait([
      _clubService.get(id),
      _membershipService.list(filter: MembershipFilter(club: id)),
      _commentService.list(filter: CommentFilter(receiver: id)),
    ]).then((value) {
      club = value[0] as Club;
      membershipsPage = value[1] as MembershipsPage;
      commentsPage = value[2] as CommentsPage;
      notifyListeners();
    });
  }

  openCommentDialog(BuildContext context, User user) async {
    final message = await showDialog<String?>(
      context: context,
      builder: (context) => CommentFormComponent(
        title: Text(
          'Comenta algo sobre ${club.name}',
          style: AppTheme.headers.headerBase,
        ),
      ),
    );
    final id = club.id;
    if (message != null && id != null) {
      var comment = Comment(owner: user, objectId: id, message: message);
      comment = await _commentService.create(comment);
      commentsPage.results.insert(0, comment);
      notifyListeners();
    }
  }
}
