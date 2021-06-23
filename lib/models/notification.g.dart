// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
    json['_id'] as String,
    json['type'] as String,
    json['description'] as String,
    json['status'] as num,
    json['origin'] as String,
    json['image'] as String,
    json['others'] as String,
  );
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'description': instance.description,
      'status': instance.status,
      'origin': instance.origin,
      'image': instance.image,
      'others': instance.others,
    };
