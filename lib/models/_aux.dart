import 'package:json_annotation/json_annotation.dart';

part 'aux.g.dart';

@JsonSerializable()
class Aux {
  String id;
  String token;
  String userName;


  Aux(this.id, this.token, this.userName);
  factory Aux.fromJson(Map<String, dynamic> json) =>
      _$AuxFromJson(json);

   Map<String, dynamic> toJson() => _$AuxToJson(this);
}
