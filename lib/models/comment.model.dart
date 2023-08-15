import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.model.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(includeIfNull: false)
  final int? id;
  @JsonKey(includeToJson: false)
  User owner;
  @JsonKey(includeToJson: false)
  String? model;
  @JsonKey(name: 'object_id')
  int objectId;
  String message;
  @JsonKey(name: 'created_at', includeToJson: false)
  String? createdAt;
  @JsonKey(name: 'time_since_created', includeToJson: false)
  String? timeSinceCreated;

  @JsonKey(name: 'owner_id', includeToJson: true)
  int? get ownerId => owner.id;

  Comment({
    this.id,
    required this.owner,
    required this.message,
    this.model,
    required this.objectId,
    this.createdAt,
    this.timeSinceCreated,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CommentsPage extends BasePage<Comment> {
  CommentsPage({
    super.count,
    super.results,
    super.next,
    super.previous,
  });

  factory CommentsPage.fromJson(Map<String, dynamic> json) =>
      _$CommentsPageFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsPageToJson(this);
}

class CommentFilter extends Filter {
  int? objectId;
  String? model;

  CommentFilter({
    this.objectId,
    this.model,
  });

  @override
  String toString() {
    String objectIdParam = objectId != null ? 'object_id=$objectId' : '';
    String modelParam = model != null ? 'content_type__model=$model' : '';

    List<String> params = [
      objectIdParam,
      modelParam,
    ].where((p) => p.isNotEmpty).toList();
    return params.isNotEmpty ? '?${params.join('&')}' : '';
  }
}

enum CommentType {
  user,
  club,
  match,
}
