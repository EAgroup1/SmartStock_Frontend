import 'package:json_annotation/json_annotation.dart';
import 'package:rlbasic/models/user.dart';

part 'lot.g.dart';

@JsonSerializable()
class Lot {
  String name;
  late String dimensions;
  late int weight;
  @JsonKey(name:'qty')
  int qty;
  int price;
  late bool isFragile;
  String info;
  @JsonKey(name:'_id')
  String id;
  int minimumQty;
  //we need that they have this lot (company & user)
  //we think that the businessItem is the first from the lot
  User businessItem;
  late User userItem;

  Lot(this.name, this.qty, this.price, this.id, this.info, this.minimumQty, this.businessItem);

  factory Lot.fromJson(Map<String, dynamic> json) => _$LotFromJson(json);

  Map<String, dynamic> toJson() => _$LotToJson(this);

}
