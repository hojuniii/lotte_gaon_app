// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Box _$BoxFromJson(Map<String, dynamic> json) {
  return Box(
    userId: json['user'] as int,
    boxNumber: json['box_number'] as String,
    customerLocation: json['customer_location'] as String,
    customerPhoneNum: json['customer_phonenum'] as String,
    customerName: json['customer_name'] as String,
    status: json['status'] as String,
    servicePlace: json['service_place'] as String,
    id: json['id'] as int,
    startedAt: json['started_at'] as String,
    completedAt: json['completed_at'] as String,
  );
}

Map<String, dynamic> _$BoxToJson(Box instance) => <String, dynamic>{
      'id': instance.id,
      'box_number': instance.boxNumber,
      'customer_location': instance.customerLocation,
      'customer_phonenum': instance.customerPhoneNum,
      'customer_name': instance.customerName,
      'status': instance.status,
      'service_place': instance.servicePlace,
      'user': instance.userId,
      'started_at': instance.startedAt,
      'completed_at': instance.completedAt,
    };
