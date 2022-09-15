import 'package:json_annotation/json_annotation.dart';

part 'reply.g.dart';

@JsonSerializable()
class Reply {
  Reply();

  @JsonKey(name: "Content")
  late String content;
  @JsonKey(name: "Created_at")
  late String createdAt;
  @JsonKey(name: "Email")
  late String email;
  @JsonKey(name: "ID")
  late num id;
  @JsonKey(name: "IsDeleted")
  late bool isDeleted;
  @JsonKey(name: "IsThumbUp")
  late bool isThumbUp;
  @JsonKey(name: "PinpinId")
  late num pinPinId;
  @JsonKey(name: "ReplyTo")
  late num replyTo;
  @JsonKey(name: "ThumbUpNum")
  late num thumbUpNum;


  @override
  String toString() {
    return 'Reply{content: $content, createdAt: $createdAt, email: $email, id: $id, isDeleted: $isDeleted, isThumbUp: $isThumbUp, pinPinId: $pinPinId, replyTo: $replyTo, thumbUpNum: $thumbUpNum}';
  }

  factory Reply.fromJson(Map<String,dynamic> json) => _$ReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
