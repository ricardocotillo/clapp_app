// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as int?,
      court: json['court'] as int?,
      user: json['user'] as int?,
      start: json['start'] as String,
      end: json['end'] as String,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BookingToJson(Booking instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user': instance.user,
    'court': instance.court,
    'start': instance.start,
    'end': instance.end,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  return val;
}

BookingsPage _$BookingsPageFromJson(Map<String, dynamic> json) => BookingsPage(
      count: json['count'] as int? ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as int?,
      previous: json['previous'] as int?,
    );
