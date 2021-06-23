// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userChat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChat _$UserChatFromJson(Map<String, dynamic> json) {
  return UserChat()
    ..userName = json['userName'] as String
    ..email = json['email'] as String
    ..id = json['_id'] as String
    ..bank = json['bank'] as String
    ..role = json['role'] as String
    ..resetLink = json['resetLink'] as String;
}

Map<String, dynamic> _$UserChatToJson(UserChat instance) => <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      '_id': instance.id,
      'bank': instance.bank,
      'role': instance.role,
      'resetLink': instance.resetLink,
    };
