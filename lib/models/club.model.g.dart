// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
      id: json['id'] as int?,
      sport: json['sport'] == null
          ? null
          : Sport.fromJson(json['sport'] as Map<String, dynamic>),
      name: json['name'] as String,
      logo: json['logo'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ClubImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      membersCount: json['members_count'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'images': instance.images,
      'sport_id': instance.sportId,
    };

ClubsPage _$ClubsPageFromJson(Map<String, dynamic> json) => ClubsPage(
      count: json['count'] as int? ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Club.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as int?,
      previous: json['previous'] as int?,
    );

Map<String, dynamic> _$ClubsPageToJson(ClubsPage instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
