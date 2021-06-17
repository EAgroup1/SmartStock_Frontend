import 'package:json_annotation/json_annotation.dart';
import 'package:rlbasic/models/user.dart';

part 'lot.g.dart';

@JsonSerializable()
class Lot {
  String name;
  String dimensions;
  String weight;
  @JsonKey(name: 'qty')
  String qty;
  String price;
  bool isFragile;
  late String info;
  @JsonKey(name: '_id')
  String id;
  String minimumQty;
  User businessItem;
  User? userItem;
  late bool stored;

  Lot(this.name, this.qty, this.price, this.id, this.minimumQty,
      this.dimensions, this.weight, this.isFragile, this.businessItem, this.userItem);

  factory Lot.fromJson(Map<String, dynamic> json) => _$LotFromJson(json);

  Map<String, dynamic> toJson() => _$LotToJson(this);
}
