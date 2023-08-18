import 'package:clapp/models/image.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'club.model.g.dart';

@JsonSerializable()
class Club {
  final int? id;
  @JsonKey(includeToJson: false)
  Sport? sport;
  String name;
  String? logo;
  List<AppImage>? images;
  @JsonKey(name: 'members_count', includeToJson: false)
  final int? membersCount;
  @JsonKey(name: 'created_at', includeToJson: false)
  String? createdAt;
  @JsonKey(name: 'updated_at', includeToJson: false)
  String? updatedAt;

  @JsonKey(name: 'sport_id', includeToJson: true)
  int? get sportId => sport?.id;

  Club({
    this.id,
    this.sport,
    required this.name,
    this.logo,
    this.images,
    this.membersCount,
    this.createdAt,
    this.updatedAt,
  });

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  Map<String, dynamic> toJson() => _$ClubToJson(this);
}

@JsonSerializable()
class ClubsPage extends BasePage<Club> {
  ClubsPage({
    super.count,
    super.results,
    super.next,
    super.previous,
  });

  factory ClubsPage.fromJson(Map<String, dynamic> json) =>
      _$ClubsPageFromJson(json);

  Map<String, dynamic> toJson() => _$ClubsPageToJson(this);
}
