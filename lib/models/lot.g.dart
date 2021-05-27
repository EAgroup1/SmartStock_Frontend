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
    json['minimumQty'] as int,
    User.fromJson(json['businessItem'] as Map<String, dynamic>),
  )
    ..dimensions = json['dimensions'] as String
    ..weight = json['weight'] as int
    ..isFragile = json['isFragile'] as bool
    ..userItem = User.fromJson(json['userItem'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LotToJson(Lot instance) => <String, dynamic>{
      'name': instance.name,
      'dimensions': instance.dimensions,
      'weight': instance.weight,
      'qty': instance.qty,
      'price': instance.price,
      'isFragile': instance.isFragile,
      'info': instance.info,
      '_id': instance.id,
      'minimumQty': instance.minimumQty,
      'businessItem': instance.businessItem,
      'userItem': instance.userItem,
    };
