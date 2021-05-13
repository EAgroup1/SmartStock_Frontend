import 'dart:html';

import 'package:rlbasic/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lot.g.dart';

@JsonSerializable()
class Lot {
  String name;
  late String dimensions;
  late int weight;
  @JsonKey(name:'qty')
  int quantity;
  int price;
  late bool isFragile;
  String info;
  @JsonKey(name:'_id')
  String id;

  Lot(this.name, this.quantity, this.price, this.id, this.info);

  factory Lot.fromJson(Map<String, dynamic> json) => _$LotFromJson(json);

  Map<String, dynamic> toJson() => _$LotToJson(this);

  /* static Lot fromJson(Map json) {
    return Lot(
        name: json['name'], quantity: json['quantity'], price: json['price'], id: json['_id'], info: json['info']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Instance of Lot : $name';
  } */
}
