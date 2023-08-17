// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      id: json['id'] as int,
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      name: json['name'] as String,
      address: json['address'] as String,
      district: json['district'] as String,
      city: json['city'] as String,
      sports: (json['sports'] as List<dynamic>)
          .map((e) => Sport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PlacePage _$PlacePageFromJson(Map<String, dynamic> json) => PlacePage(
      count: json['count'] as int? ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Place.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as int?,
      previous: json['previous'] as int?,
    );
