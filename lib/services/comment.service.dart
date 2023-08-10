import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/comment.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class CommentService extends BaseService<Comment> {
  final CommentType receiver;

  // user, club or match
  CommentService({required this.receiver});

  @override
  String get base => '${Config.domain}/api/${receiver.name}-comments/';

  @override
  Future<CommentsPage> list({Filter? filter}) async {
    String url = base;
    if (filter != null) {
      url += filter.toString();
    }
    final uri = Uri.parse(url);
    final res = await http.get(
      uri,
      headers: await headers,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return CommentsPage.fromJson(j);
  }

  @override
  Future<Comment> get(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Comment> create(Comment model) async {
    final url = Uri.parse(base);
    final res = await http.post(
      url,
      headers: await headers,
      body: jsonEncode(model),
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return Comment.fromJson(j);
  }
}
