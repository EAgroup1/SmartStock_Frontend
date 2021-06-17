// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Delivery _$DeliveryFromJson(Map<String, dynamic> json) {
  return Delivery(
    Lot.fromJson(json['lotItem'] as Map<String, dynamic>),
    json['_id'] as String,
    json['deliveryDate'] as String,
    User.fromJson(json['businessItem'] as Map<String, dynamic>),
    json['description'] as String,
    json['isDelivered'] as bool,
    json['isPicked'] as bool,
  )
    ..userItem = User.fromJson(json['userItem'] as Map<String, dynamic>)
    ..time = json['time'] as String;
}

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'lotItem': instance.lot,
      '_id': instance.id,
      'deliveryDate': instance.deliveryDate,
      'businessItem': instance.businessItem,
      'userItem': instance.userItem,
      'description': instance.description,
      'isPicked': instance.isPicked,
      'isDelivered': instance.isDelivered,
      'time': instance.time,
    };
