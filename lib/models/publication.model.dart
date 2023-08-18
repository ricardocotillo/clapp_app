import 'package:clapp/models/page.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'publication.model.g.dart';

@JsonSerializable()
class Publication {
  final int id;
  final User? user;
  final String? body;
  final String? image;
  final bool private;
  @JsonKey(name: 'created_at', includeToJson: false)
  final String createdAt;
  @JsonKey(name: 'time_since_created', includeToJson: false)
  final String timeSinceCreated;
  @JsonKey(name: 'updated_at', includeToJson: false)
  final String updatedAt;
  @JsonKey(name: 'time_since_updated', includeToJson: false)
  final String timeSinceUpdated;

  Publication({
    this.id = 0,
    this.user,
    this.body,
    this.image,
    this.private = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.timeSinceCreated = '',
    this.timeSinceUpdated = '',
  });

  String? get excerpt => body != null && body!.length > 100
      ? '${body!.substring(0, 100)}...'
      : body;

  factory Publication.fromJson(Map<String, dynamic> json) =>
      _$PublicationFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationToJson(this);
}

@JsonSerializable()
class PublicationsPage extends BasePage<Publication> {
  PublicationsPage({
    required super.count,
    required super.results,
    super.next,
    super.previous,
  });

  factory PublicationsPage.fromJson(Map<String, dynamic> json) =>
      _$PublicationsPageFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationsPageToJson(this);
}
