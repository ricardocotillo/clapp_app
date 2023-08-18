import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class UserService extends BaseService<User> {
  @override
  String get base => '${Config.domain}/api/users';

  @override
  Future<UsersPage> list({Filter? filter}) async {
    var url = '$base/';
    if (filter != null) {
      url += filter.urlParams;
    }
    final uri = Uri.parse(url);
    final res = await http.get(
      uri,
      headers: await headers,
    );
    final j = jsonDecode(res.body);
    return UsersPage.fromJson(j);
  }

  @override
  Future<User> get(int id) async {
    final url = Uri.parse('$base/$id/');
    final res = await http.get(
      url,
      headers: await headers,
    );
    final j = jsonDecode(res.body);
    return User.fromJson(j);
  }

  @override
  Future<User> create(User model) {
    throw UnimplementedError();
  }
}
