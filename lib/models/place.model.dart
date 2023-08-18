import 'package:clapp/models/court.model.dart';
import 'package:clapp/models/image.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'place.model.g.dart';

@JsonSerializable(createToJson: false)
class Place {
  final int id;
  final User? owner;
  final String? name;
  final String? address;
  final String? district;
  final String? city;
  final List<AppImage>? images;
  final List<Court>? courts;

  Place({
    required this.id,
    this.owner,
    this.name,
    this.address,
    this.district,
    this.city,
    this.images,
    this.courts,
  });

  String get fullAddress => '$address, $district - $city';

  Map<Sport, List<Court>> get groupedCourts {
    final grouped = <Sport, List<Court>>{};
    courts?.forEach((c) {
      final sport = c.sport;
      sport != null && grouped.containsKey(sport)
          ? (grouped[sport] as List).add(c)
          : grouped[sport!] = [c];
    });
    return grouped;
  }

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
