import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/membership.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class MembershipService extends BaseService<Membership> {
  @override
  String get base => '${Config.domain}/api/memberships';

  @override
  Future<MembershipsPage> list({Filter? filter}) async {
    String url = '$base/';
    if (filter != null) {
      url += filter.urlParams;
    }
    final uri = Uri.parse(url);
    final res = await http.get(
      uri,
      headers: await headers,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return MembershipsPage.fromJson(j);
  }

  @override
  Future<Membership> get(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Membership> create(Membership model) {
    throw UnimplementedError();
  }
}
