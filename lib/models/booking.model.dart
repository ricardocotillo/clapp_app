import 'package:clapp/models/page.model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking.model.g.dart';

@JsonSerializable()
class Booking {
  final int? id;
  final int? user;
  final int? court;
  String start;
  String end;
  @JsonKey(includeIfNull: false)
  String? status;

  Booking({
    this.id,
    this.court,
    this.user,
    required this.start,
    required this.end,
    this.status,
  });

  DateTime get startDate => DateTime.parse(start).toLocal();
  DateTime get endDate => DateTime.parse(end).toLocal();

  Duration get duration => endDate.difference(startDate);

  bool contains(DateTimeRange d) {
    return startDate.isAtSameMomentAs(d.start);
  }

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable(createToJson: false)
class BookingsPage extends BasePage<Booking> {
  BookingsPage({
    super.count,
    super.results,
    super.next,
    super.previous,
  });

  factory BookingsPage.fromJson(Map<String, dynamic> json) =>
      _$BookingsPageFromJson(json);
}
