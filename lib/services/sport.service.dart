import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class SportService extends BaseService {
  @override
  String get base => '${Config.base}/sports';

  @override
  Future<SportsPage> list({Filter? filter}) async {
    final uri = Uri.parse('$base/');
    final res = await http.get(
      uri,
      headers: await headers,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return SportsPage.fromJson(j);
  }

  @override
  Future create(model) {
    throw UnimplementedError();
  }

  @override
  Future get(int id) {
    throw UnimplementedError();
  }
}
