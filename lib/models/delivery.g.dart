// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Delivery _$DeliveryFromJson(Map<String, dynamic> json) {
  return Delivery(
    json['destinationLocation'] as String,
    User.fromJson(json['destinationItem'] as Map<String, dynamic>),
    json['isReady'] as bool?,
    json['isAssigned'] as bool?,
    User.fromJson(json['userItem'] as Map<String, dynamic>),
    Lot.fromJson(json['lotItem'] as Map<String, dynamic>),
    json['_id'] as String,
    json['deliveryDate'] as String?,
    User.fromJson(json['businessItem'] as Map<String, dynamic>),
    json['description'] as String?,
    json['originLocation'] as String,
    json['isDelivered'] as bool?,
    json['isPicked'] as bool?,
  );
}

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'lotItem': instance.lot,
      '_id': instance.id,
      'originLocation': instance.originLocation,
      'destinationLocation': instance.destinationLocation,
      'destinationItem': instance.destinationItem,
      'deliveryDate': instance.deliveryDate,
      'isPicked': instance.isPicked,
      'isDelivered': instance.isDelivered,
      'isReady': instance.isReady,
      'businessItem': instance.businessItem,
      'isAssigned': instance.isAssigned,
      'userItem': instance.userItem,
      'description': instance.description,
    };
