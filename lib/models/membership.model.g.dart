// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Membership _$MembershipFromJson(Map<String, dynamic> json) => Membership(
      id: json['id'] as int?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      role: json['role'] as String,
      team: json['team'] as bool,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$MembershipToJson(Membership instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'role': instance.role,
      'team': instance.team,
    };

MembershipsPage _$MembershipsPageFromJson(Map<String, dynamic> json) =>
    MembershipsPage(
      count: json['count'] as int? ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Membership.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as int?,
      previous: json['previous'] as int?,
    );

Map<String, dynamic> _$MembershipsPageToJson(MembershipsPage instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
