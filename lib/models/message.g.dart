// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['_id'] as String,
    json['text'] as String,
    json['senderID'] as String,
    json['receiverID'] as String,
      );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'text': instance.text,
      'senderID': instance.senderID,
      '_id': instance.id,
      'bank': instance.receiverID,
    };
