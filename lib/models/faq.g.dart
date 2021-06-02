// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faq _$FaqFromJson(Map<String, dynamic> json) {
  return Faq(
    json['title'] as String,
    json['content'] as String,
    json['type'] as String
  );
}

Map<String, dynamic> _$FaqToJson(Faq instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'type': instance.type
    };
