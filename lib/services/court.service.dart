import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/court.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class CourtService extends BaseService<Court> {
  @override
  String get base => '${Config.base}/courts';
  @override
  Future<Court> create(Court model) {
    throw UnimplementedError();
  }

  @override
  Future<Court> get(int id) async {
    final url = '$base/$id/';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: await headers);
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return Court.fromJson(j);
  }

  @override
  Future<BasePage> list({Filter? filter}) {
    throw UnimplementedError();
  }
}
