import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userName;
  String email;
  @JsonKey(name: '_id')
  String id;
  String bank;
  String role;
  int badges;
  User(this.id, this.userName, this.email, this.bank, this.role, this.badges);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /* User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        userName = json['userName'],
        email = json['email'];

  Map <String, dynamic> toJson() =>
  {
    'userName':userName,
    'email':email,
  }; */
}
