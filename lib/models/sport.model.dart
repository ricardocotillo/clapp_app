import 'package:clapp/models/page.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sport.model.g.dart';

@JsonSerializable()
class Sport {
  final int id;
  final String name;

  Sport({
    required this.id,
    required this.name,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);
  Map<String, dynamic> toJson() => _$SportToJson(this);
}

@JsonSerializable()
class SportsPage extends BasePage<Sport> {
  SportsPage({
    super.count,
    super.results,
    super.next,
    super.previous,
  });

  factory SportsPage.fromJson(Map<String, dynamic> json) =>
      _$SportsPageFromJson(json);
  Map<String, dynamic> toJson() => _$SportsPageToJson(this);
}
