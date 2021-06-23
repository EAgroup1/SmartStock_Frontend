import 'package:json_annotation/json_annotation.dart';
import 'package:rlbasic/models/message.dart';
import 'package:rlbasic/models/userChat.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userName;
  String email;
  @JsonKey(name: '_id')
  String id;
  String bank;
  String role; 
  List<UserChat> friends;
  String resetLink;
  List<Message> messages;
  User(this.id, this.userName, this.email, this.bank, this.role, this.friends,this.resetLink,this.messages);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

 /*  User.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
      userName = json['userName'],
      email = json['email'],
      bank = json['bank'],
      role = json['role'],
      friends = new List<String>.from(json['friends']),
      resetLink = json['resetLink'];

 
  Map <String, dynamic> toJson() =>
  {
    'userName':userName,
    'email':email,
  }; */
}
