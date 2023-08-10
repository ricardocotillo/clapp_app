import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/publication.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class PublicationService extends BaseService<Publication> {
  @override
  String get base => '${Config.base}/publications';

  @override
  Future<PublicationsPage> list({Filter? filter}) async {
    final Uri uri = Uri.parse('$base/');
    final res = await http.get(uri);
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return PublicationsPage.fromJson(j);
  }

  @override
  Future<Publication> get(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Publication> create(Publication model) async {
    final Uri uri = Uri.parse('$base/');
    final res =
        await http.post(uri, body: jsonEncode(model), headers: await headers);
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return Publication.fromJson(j);
  }
}
