// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int?,
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      message: json['message'] as String,
      model: json['model'] as String?,
      objectId: json['object_id'] as int,
      createdAt: json['created_at'] as String?,
      timeSinceCreated: json['time_since_created'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['object_id'] = instance.objectId;
  val['message'] = instance.message;
  val['owner_id'] = instance.ownerId;
  return val;
}

CommentsPage _$CommentsPageFromJson(Map<String, dynamic> json) => CommentsPage(
      count: json['count'] as int? ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as int?,
      previous: json['previous'] as int?,
    );

Map<String, dynamic> _$CommentsPageToJson(CommentsPage instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
