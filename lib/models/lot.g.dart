// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lot _$LotFromJson(Map<String, dynamic> json) {
  return Lot(
    json['name'] as String,
    json['qty'] as int,
    json['price'] as int,
    json['_id'] as String,
    json['info'] as String,
  )
    ..dimensions = json['dimensions'] as String
    ..weight = json['weight'] as int
    ..isFragile = json['isFragile'] as bool;
}

Map<String, dynamic> _$LotToJson(Lot instance) => <String, dynamic>{
      'name': instance.name,
      'dimensions': instance.dimensions,
      'weight': instance.weight,
      'qty': instance.quantity,
      'price': instance.price,
      'isFragile': instance.isFragile,
      'info': instance.info,
      '_id': instance.id,
    };
