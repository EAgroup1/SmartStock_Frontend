import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String text;
  String senderID;
  //finally we don't include the id for the qty of messages
  String receiverID;
  Message(this.text, this.senderID, this.receiverID);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}