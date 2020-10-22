import 'package:json_annotation/json_annotation.dart';
import 'package:gaon/model/profile.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String username;
  Profile profile;

  User({this.id, this.username, this.profile});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
