import 'package:json_annotation/json_annotation.dart';
part 'booking.model.g.dart';

@JsonSerializable()
class Booking {
  final int? id;
  String start;
  String end;
  String status;

  Booking({
    this.id,
    required this.start,
    required this.end,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
