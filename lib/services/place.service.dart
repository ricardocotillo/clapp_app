import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/place.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class PlaceService extends BaseService<Place> {
  @override
  String get base => '${Config.base}/places';

  @override
  Future<Place> create(Place model) {
    throw UnimplementedError();
  }

  @override
  Future<Place> get(int id) async {
    final url = '$base/$id';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: await headers);
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return Place.fromJson(j);
  }

  @override
  Future<PlacePage> list({Filter? filter}) async {
    final url = '$base/$filter';
    final uri = Uri.parse(url);
    final res = await http.get(
      uri,
      headers: await headers,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return PlacePage.fromJson(j);
  }
}
