// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    userPk: json['user_pk'] as int,
    nickname: json['nickname'] as String,
    phone: json['phone'] as String,
    profileImage: json['profile_image'] as String,
    servicePlace: json['service_place'] as String,
    age: json['age'] as int,
    birth: json['birth'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user_pk': instance.userPk,
      'nickname': instance.nickname,
      'phone': instance.phone,
      'profile_image': instance.profileImage,
      'service_place': instance.servicePlace,
      'birth': instance.birth,
      'age': instance.age,
    };
