import 'package:clapp/models/booking.model.dart';
import 'package:clapp/models/court.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/services/booking.service.dart';
import 'package:clapp/services/court.service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookProvider extends ChangeNotifier {
  Court? court;
  var bookingsPage = BookingsPage();
  final bookingService = BookingService();
  final courtService = CourtService();
  final DateTime now = DateTime.now();
  List<DateTimeRange> selectedSlots = <DateTimeRange>[];
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
    final startHour = court?.startHour;
    final endHour = court?.endHour;
    final duration = court?.blockDuration;
    if (startHour == null || endHour == null || duration == null) {
      return [];
    }
    final start = days[selectedDay]
        .copyWith(hour: startHour.hour, minute: startHour.minute);
    final end =
        days[selectedDay].copyWith(hour: endHour.hour, minute: endHour.minute);
    final diff = end.difference(start);
    final num = diff.inMinutes ~/ duration.inMinutes;
    return List.generate(
      num,
      (i) => DateTimeRange(
        start: start.add(
          Duration(
            minutes: duration.inMinutes * i,
          ),
        ),
        end: start.add(
          Duration(
            minutes: duration.inMinutes * (i + 1),
          ),
        ),
      ),
    );
  }

  onSelected(DateTimeRange d) {
    selectedSlots.contains(d)
        ? selectedSlots.removeWhere((s) => s == d)
        : selectedSlots.add(d);
    notifyListeners();
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
