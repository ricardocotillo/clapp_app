import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/club.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class ClubService extends BaseService<Club> {
  @override
  String get base => '${Config.domain}/api/clubs';

  @override
  Future<ClubsPage> list({
    Filter? filter,
  }) async {
    String url = '$base/';
    if (filter != null) {
      url += filter.toString();
    }
    final uri = Uri.parse(url);
    final res = await http.get(
      uri,
      headers: await headers,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return ClubsPage.fromJson(j);
  }

  @override
  Future<Club> get(int id) async {
    final url = Uri.parse('$base/$id/');
    final res = await http.get(
      url,
      headers: await headers,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return Club.fromJson(j);
  }

  @override
  Future<Club> create(Club model) async {
    final url = Uri.parse('$base/');
    final res = await http.post(
      url,
      headers: await headers,
      body: jsonEncode(model),
    );
    if (res.statusCode == 400) {
      Map<String, dynamic> errors = jsonDecode(res.body);
      throw errors['name']?[0] ?? '';
    }
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return Club.fromJson(j);
  }
}
