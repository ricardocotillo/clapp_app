import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'place.model.g.dart';

@JsonSerializable(createToJson: false)
class Place {
  final int id;
  final User owner;
  final String name;
  final String address;
  final String district;
  final String city;
  final List<Sport> sports;

  Place({
    required this.id,
    required this.owner,
    required this.name,
    required this.address,
    required this.district,
    required this.city,
    required this.sports,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlacePage extends BasePage<Place> {
  PlacePage({
    super.count,
    super.results,
    super.next,
    super.previous,
  });

  factory PlacePage.fromJson(Map<String, dynamic> json) =>
      _$PlacePageFromJson(json);
}

class PlaceFilter extends Filter {
  Map<String, dynamic> params;

  PlaceFilter({
    this.params = const {},
  });

  @override
  String toString() {
    if (params.isNotEmpty) {
      final p = params.keys.map((k) => '$k=${params[k]}').join('&');
      return '?$p';
    }
    return '';
  }
}
