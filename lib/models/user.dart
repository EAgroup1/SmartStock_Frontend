import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userName;
  String email;
  @JsonKey(name: '_id')
  String id;
  late bool privacity;
  late bool notifications;
  String bank;
  String role;
  User(this.id, this.userName, this.email, this.bank, this.role);

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
