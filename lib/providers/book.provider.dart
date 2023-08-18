import 'package:clapp/models/court.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/services/booking.service.dart';
import 'package:clapp/services/court.service.dart';
import 'package:flutter/foundation.dart';

class BookProvider extends ChangeNotifier {
  Court? court;
  final bookingService = BookingService();
  final courtService = CourtService();
  final DateTime now = DateTime.now();
  int selectedDay = 0;
  Filter get filter => Filter(
        params: {
          'court': court?.id,
        },
      );

  List<DateTime> get days => List.generate(
        7,
        (i) => now.add(
          Duration(
            days: i,
          ),
        ),
      );

  BookProvider({required int courtId}) {
    courtService.get(courtId).then((c) => court = c);
  }
}
