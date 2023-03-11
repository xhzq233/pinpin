import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

part 'reply.g.dart';

@Entity(foreignKeys: [
  ForeignKey(childColumns: ['replyTo'], parentColumns: ['id'], entity: Reply),
  ForeignKey(childColumns: ['pinPinId'], parentColumns: ['pinpinId'], entity: PinPin),
])
@JsonSerializable()
class Reply {
  Reply({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.email,
    required this.isDeleted,
    required this.isThumbUp,
    required this.pinPinId,
    required this.replyTo,
    required this.thumbUpint,
  });

  @JsonKey(name: "Content")
  final String content;
  @JsonKey(name: "Created_at")
  final String createdAt;
  @JsonKey(name: "Email")
  final String email;
  @primaryKey
  @JsonKey(name: "ID")
  final int id;
  @JsonKey(name: "IsDeleted")
  final bool isDeleted;
  @JsonKey(name: "IsThumbUp")
  final bool isThumbUp;
  @JsonKey(name: "PinpinId")
  final int pinPinId;
  @JsonKey(name: "ReplyTo")
  final int replyTo;
  @JsonKey(name: "ThumbUpint")
  final int thumbUpint;

  @override
  String toString() {
    return 'Reply{content: $content, createdAt: $createdAt, email: $email, id: $id, isDeleted: $isDeleted, isThumbUp: $isThumbUp, pinPinId: $pinPinId, replyTo: $replyTo, thumbUpint: $thumbUpint}';
  }

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
