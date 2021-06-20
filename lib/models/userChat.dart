import 'package:json_annotation/json_annotation.dart';

part 'userChat.g.dart';

@JsonSerializable()
class UserChat {
  late String userName;
  late String email;
  @JsonKey(name: '_id')
  late String id;
  late String bank;
  late String role;
  late String resetLink;

  UserChat();
  factory UserChat.fromJson(Map<String, dynamic> json) => _$UserChatFromJson(json);

  fromJson(i) {}

}
