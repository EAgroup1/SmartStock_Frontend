import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  @JsonKey(name: '_id')
  String id;
  String type;
  String description;
  @JsonKey(name: 'status')
  num status;
  String origin;
  String image;
  String others;

  Notification(this.id, this.type, this.description, this.status, this.origin, this.image,
      this.others);

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}