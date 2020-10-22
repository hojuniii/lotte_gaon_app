import 'package:json_annotation/json_annotation.dart';

part 'box.g.dart';

@JsonSerializable(explicitToJson: true)
class Box {
  int id;
  @JsonKey(name: 'box_number')
  String boxNumber;
  @JsonKey(name: 'customer_location')
  String customerLocation;
  @JsonKey(name: 'customer_phonenum')
  String customerPhoneNum;
  @JsonKey(name: 'customer_name')
  String customerName;
  String status;
  @JsonKey(name: 'service_place')
  String servicePlace;
  @JsonKey(name: 'user')
  int userId;
  @JsonKey(name: 'started_at')
  String startedAt;
  @JsonKey(name: 'completed_at')
  String completedAt;

  Box({
    this.userId,
    this.boxNumber,
    this.customerLocation,
    this.customerPhoneNum,
    this.customerName,
    this.status,
    this.servicePlace,
    this.id,
    this.startedAt,
    this.completedAt,
  });

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
  Map<String, dynamic> toJson() => _$BoxToJson(this);
}
