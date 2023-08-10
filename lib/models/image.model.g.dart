// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubImage _$ClubImageFromJson(Map<String, dynamic> json) => ClubImage(
      id: json['id'] as int?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      image: json['image'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ClubImageToJson(ClubImage instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'image': instance.image,
      'description': instance.description,
    };
