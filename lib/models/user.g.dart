// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['_id'] as String,
    json['userName'] as String,
    json['email'] as String,
    json['bank'] as String,
    json['role'] as String,
  )
    ..privacity = json['privacity'] as bool
    ..notifications = json['notifications'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      '_id': instance.id,
      'privacity': instance.privacity,
      'notifications': instance.notifications,
      'bank': instance.bank,
      'role': instance.role,
    };
