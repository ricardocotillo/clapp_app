import 'package:clapp/models/image.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'court.model.g.dart';

@JsonSerializable(createToJson: false)
class Court {
  final int id;
  final String? name;
  final List<AppImage>? images;
  final List<int>? days;
  final String? duration;
  final String? start;
  final String? end;
  final String? price;
  final Sport? sport;

  Court({
    required this.id,
    required this.name,
    this.images,
    required this.days,
    required this.duration,
    required this.start,
    required this.end,
    required this.price,
    required this.sport,
  });

  String get formattedPrice => 'S/$price';
  TimeOfDay? get startHour {
    if (start == null) return null;
    final parts = start!.split(':').map((s) => int.parse(s)).toList();
    return TimeOfDay(hour: parts[0], minute: parts[1]);
  }

  TimeOfDay? get endHour {
    if (end == null) return null;
    final parts = end!.split(':').map((s) => int.parse(s)).toList();
    return TimeOfDay(hour: parts[0], minute: parts[1]);
  }

  Duration? get blockDuration {
    if (duration == null) return null;
    return parseTime('$duration.000000');
  }

  factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);
}
