import 'package:clapp/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image.model.g.dart';

@JsonSerializable()
class ClubImage {
  final int? id;
  User user;
  String image;
  String? description;

  ClubImage({
    this.id,
    required this.user,
    required this.image,
    this.description,
  });

  factory ClubImage.fromJson(Map<String, dynamic> json) =>
      _$ClubImageFromJson(json);

  Map<String, dynamic> toJson() => _$ClubImageToJson(this);
}
