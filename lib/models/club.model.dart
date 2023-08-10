import 'package:clapp/models/filter.model.dart';
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
  List<ClubImage>? images;
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

class ClubFilter extends Filter {
  int? owner;
  List<int>? members;
  List<int>? sport;

  ClubFilter({
    this.owner,
    this.members,
    this.sport,
    super.page,
  });

  @override
  String toString() {
    String pageParam = page != null ? 'page=$page' : '';
    String ownerParam = owner != null ? 'owner=$owner' : '';
    String membersParam =
        members != null ? members!.map((m) => 'members=$m').join('&') : '';
    String sportParam = sport != null
        ? 'sport=${sport!.map((s) => s.toString()).join(',')}'
        : '';
    List<String> params = [
      pageParam,
      ownerParam,
      membersParam,
      sportParam,
    ].where((p) => p.isNotEmpty).toList();
    return params.isNotEmpty ? '?${params.join('&')}' : '';
  }
}
