import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String text;
  String senderID;
  @JsonKey(name: '_id')
  String id;
  String receiverID;
  Message(this.id, this.text, this.senderID, this.receiverID);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}