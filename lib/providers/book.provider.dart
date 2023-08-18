import 'package:clapp/models/filter.model.dart';
import 'package:clapp/services/booking.service.dart';
import 'package:flutter/foundation.dart';

class BookProvider extends ChangeNotifier {
  final int courtId;
  final bookingService = BookingService();
  final DateTime now = DateTime.now();
  int selectedDay = 0;
  Filter get filter => Filter(
        params: {
          'court': courtId,
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

  BookProvider({required this.courtId});
}
