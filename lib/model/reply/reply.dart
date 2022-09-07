import 'package:json_annotation/json_annotation.dart';

part 'reply.g.dart';

@JsonSerializable()
class Reply {
  Reply();

  late String Content;
  late String Created_at;
  late String Email;
  late num ID;
  late bool IsDeleted;
  late bool IsThumbUp;
  late num PinpinId;
  late num ReplyTo;
  late num ThumbUpNum;


  @override
  String toString() {
    return 'Reply{Content: $Content, Created_at: $Created_at, Email: $Email, ID: $ID, IsDeleted: $IsDeleted, IsThumbUp: $IsThumbUp, PinpinId: $PinpinId, ReplyTo: $ReplyTo, ThumbUpNum: $ThumbUpNum}';
  }

  factory Reply.fromJson(Map<String,dynamic> json) => _$ReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
