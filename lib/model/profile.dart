import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  @JsonKey(name: 'user_pk')
  int userPk;
  String nickname;
  String phone;
  @JsonKey(name: 'profile_image')
  String profileImage;
  @JsonKey(name: 'service_place')
  String servicePlace;
  String birth;
  int age;

  Profile({
    this.userPk,
    this.nickname,
    this.phone,
    this.profileImage,
    this.servicePlace,
    this.age,
    this.birth,
  }) {
    phone = phone.toString();
  }

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
