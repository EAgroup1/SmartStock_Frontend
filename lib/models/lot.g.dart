// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lot _$LotFromJson(Map<String, dynamic> json) {
  return Lot(
    json['name'] as String,
    json['qty'] as String,
    json['price'] as String,
    json['_id'] as String,
    json['minimumQty'] as String,
    json['dimensions'] as String,
    json['weight'] as String,
    json['isFragile'] as bool,
    User.fromJson(json['businessItem'] as Map<String, dynamic>),
    json['userItem'] == null
        ? null
        : User.fromJson(json['userItem'] as Map<String, dynamic>),
  )
    ..info = json['info'] as String
    ..stored = json['stored'] as bool
    ..delivered = json['delivered'] as bool
    ..picked = json['picked'] as bool;
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
      'stored': instance.stored,
      'delivered': instance.delivered,
      'picked': instance.picked,
    };
