// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publication _$PublicationFromJson(Map<String, dynamic> json) => Publication(
      id: json['id'] as int? ?? 0,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      body: json['body'] as String?,
      image: json['image'] as String?,
      private: json['private'] as bool? ?? false,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      timeSinceCreated: json['time_since_created'] as String? ?? '',
      timeSinceUpdated: json['time_since_updated'] as String? ?? '',
    );

Map<String, dynamic> _$PublicationToJson(Publication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'body': instance.body,
      'image': instance.image,
      'private': instance.private,
    };

PublicationsPage _$PublicationsPageFromJson(Map<String, dynamic> json) =>
    PublicationsPage(
      count: json['count'] as int? ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Publication.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as int?,
      previous: json['previous'] as int?,
    );

Map<String, dynamic> _$PublicationsPageToJson(PublicationsPage instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
