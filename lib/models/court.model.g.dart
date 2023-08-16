// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Court _$CourtFromJson(Map<String, dynamic> json) => Court(
      id: json['id'] as int,
      name: json['name'] as String,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => AppImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      days: (json['days'] as List<dynamic>).map((e) => e as int).toList(),
      duration: json['duration'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      price: json['price'] as String,
    );
