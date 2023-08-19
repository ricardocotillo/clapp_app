import 'package:clapp/models/booking.model.dart';
import 'package:clapp/models/court.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/services/booking.service.dart';
import 'package:clapp/services/court.service.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookProvider extends ChangeNotifier {
  Court? court;
  var bookingsPage = BookingsPage();
  final bookingService = BookingService();
  final courtService = CourtService();
  final DateTime now = DateTime.now();
  int selectedDay = 0;

  List<DateTime> get days => List.generate(
        7,
        (i) => now.add(
          Duration(
            days: i,
          ),
        ),
      );

  Filter get filter => Filter(
        params: {
          'court': court?.id,
          'start_date': DateFormat('y-MM-dd').format(days[selectedDay]),
        },
      );

  List<DateTimeRange> get slots {
    final start = court?.startHour;
    final end = court?.endHour;
    final duration = court?.blockDuration;
    if (start == null || end == null || duration == null) return [];
    return [];
  }

  BookProvider({required int courtId}) {
    Future.wait([
      courtService.get(courtId),
      bookingService.list(filter: filter),
    ]).then((values) {
      final [c as Court, b as BookingsPage] = values;
      court = c;
      bookingsPage = b;
      notifyListeners();
    });
  }
}
