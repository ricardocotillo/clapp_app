import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/booking.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/services/base.service.dart';
import 'package:http/http.dart' as http;

class BookingService extends BaseService<Booking> {
  @override
  String get base => '${Config.base}/bookings';

  @override
  Future<Booking> create(Booking model) async {
    final url = '$base/';
    final uri = Uri.parse(url);
    final res = await http.post(
      uri,
      body: jsonEncode(model),
      headers: await headers,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return Booking.fromJson(j);
  }

  @override
  Future<Booking> get(int id) {
    throw UnimplementedError();
  }

  @override
  Future<BookingsPage> list({Filter? filter}) async {
    final url = '$base/${filter?.urlParams ?? ''}';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: await headers);
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return BookingsPage.fromJson(j);
  }
}
