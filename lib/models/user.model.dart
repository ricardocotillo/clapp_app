import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
part 'user.model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class User {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  String email;
  @HiveField(2)
  @JsonKey(name: 'first_name')
  String firstName;
  @HiveField(3)
  @JsonKey(name: 'last_name')
  String lastName;
  @HiveField(4)
  String image;
  @HiveField(5)
  double? rating;
  @HiveField(6)
  @JsonKey(name: 'matches_assisted')
  int matchesAssisted;
  @HiveField(7)
  @JsonKey(name: 'matches_abandoned')
  int matchesAbandoned;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
    this.rating,
    required this.matchesAssisted,
    required this.matchesAbandoned,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(createToJson: false)
class UsersPage extends BasePage<User> {
  UsersPage({
    super.count,
    super.results,
    super.next,
    super.previous,
  });

  // List<User> get users => super.results.map((j) => User.fromJson(j)).toList();

  factory UsersPage.fromJson(Map<String, dynamic> json) =>
      _$UsersPageFromJson(json);
}

class UserFilter extends Filter {
  UserFilter({
    super.search,
  });

  @override
  String toString() {
    List<String> params = [
      searchParam,
    ].where((p) => p.isNotEmpty).toList();
    return params.isNotEmpty ? '?${params.join('&')}' : '';
  }
}
