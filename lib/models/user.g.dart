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
    (json['friends'] as List<dynamic>)
        .map((e) => UserChat.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['resetLink'] as String,
    (json['messages'] as List<dynamic>)
        .map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      '_id': instance.id,
      'bank': instance.bank,
      'role': instance.role,
      'friends': instance.friends,
      'resetLink': instance.resetLink,
      'messages': instance.messages,
    };
