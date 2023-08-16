import 'package:clapp/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image.model.g.dart';

@JsonSerializable()
class AppImage {
  final int? id;
  User user;
  String image;
  String? description;

  AppImage({
    this.id,
    required this.user,
    required this.image,
    this.description,
  });

  factory AppImage.fromJson(Map<String, dynamic> json) =>
      _$AppImageFromJson(json);

  Map<String, dynamic> toJson() => _$AppImageToJson(this);
}
