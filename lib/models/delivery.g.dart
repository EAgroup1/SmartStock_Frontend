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
    json['originLocation'] as String,
    json['isDelivered'] as bool,
    json['isPicked'] as bool,
  )
    ..destinationLocation = json['destinationLocation'] as String?
    ..userItem = json['userItem'] == null
        ? null
        : User.fromJson(json['userItem'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'lotItem': instance.lot,
      '_id': instance.id,
      'originLocation': instance.originLocation,
      'destinationLocation': instance.destinationLocation,
      'isPicked': instance.isPicked,
      'isDelivered': instance.isDelivered,
      'deliveryDate': instance.deliveryDate,
      'businessItem': instance.businessItem,
      'userItem': instance.userItem,
      'description': instance.description,
    };
