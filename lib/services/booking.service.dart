import 'package:clapp/config.dart';
import 'package:clapp/models/booking.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:clapp/services/base.service.dart';

class BookingService extends BaseService<Booking> {
  @override
  String get base => '${Config.base}/bookings';

  @override
  Future<Booking> create(Booking model) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Booking> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<BasePage> list({Filter? filter}) {
    throw UnimplementedError();
  }
}
