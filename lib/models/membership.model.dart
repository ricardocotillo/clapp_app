import 'package:clapp/models/page.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'membership.model.g.dart';

@JsonSerializable()
class Membership {
  final int? id;
  final User user;
  String role;
  bool team;
  @JsonKey(name: 'created_at', includeToJson: false)
  final String? createdAt;
  @JsonKey(name: 'updated_at', includeToJson: false)
  final String? updatedAt;

  Membership({
    this.id,
    required this.user,
    required this.role,
    required this.team,
    this.createdAt,
    this.updatedAt,
  });

  String get localizedRole => role == 'owner'
      ? 'Creador'
      : role == 'member'
          ? 'Miembro'
          : 'Administrador';

  factory Membership.fromJson(Map<String, dynamic> json) =>
      _$MembershipFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipToJson(this);
}

@JsonSerializable()
class MembershipsPage extends BasePage<Membership> {
  MembershipsPage({
    super.count,
    super.results,
    super.next,
    super.previous,
  });

  factory MembershipsPage.fromJson(Map<String, dynamic> json) =>
      _$MembershipsPageFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipsPageToJson(this);
}
