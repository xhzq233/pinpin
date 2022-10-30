import 'package:json_annotation/json_annotation.dart';

part 'pin_pin.g.dart';

@JsonSerializable(explicitToJson: true)
class PinPin {
  PinPin({
    required this.pinpinId,
    required this.title,
    required this.type,
    required this.deadline,
    required this.demandingNum,
    required this.isFollowed,
    required this.nowNum,
    required this.label,
    required this.ownerEmail,
    required this.updatedAt,
    required this.description,
  });

  @JsonKey(name: "PinpinId")
  int pinpinId;

  @JsonKey(name: "Type")
  int type;

  @JsonKey(name: "Label")
  int label;

  @JsonKey(name: "Title")
  String title;

  @JsonKey(name: "Deadline", fromJson: DateTime.parse)
  DateTime deadline;

  @JsonKey(name: "DemandingNum")
  int demandingNum;

  @JsonKey(name: "NowNum")
  int nowNum;

  @JsonKey(name: "OwnerEmail")
  String ownerEmail;

  @JsonKey(name: "UpdatedAt")
  int updatedAt;

  @JsonKey(name: "IsFollowed", defaultValue: false)
  bool isFollowed;

  @JsonKey(name: "Description")
  String description;

  @JsonKey(name: "DemandingDescription", defaultValue: 'No demanding description')
  late String demandingDescription;

  @JsonKey(name: "TeamIntroduction", defaultValue: 'No team introduction')
  late String teamIntroduction;

  @JsonKey(name: "IsDeleted", defaultValue: false)
  late bool isDeleted;

  @JsonKey(name: "CreatedAt", defaultValue: 0)
  late int createdAt;

  @JsonKey(name: "ReplyNum", defaultValue: 0)
  late int replyNum;

  @override
  String toString() {
    return 'PinPin(pinpinId: $pinpinId, type: $type, label: $label, title: $title, deadline: $deadline, demandingNum: $demandingNum, nowNum: $nowNum, ownerEmail: $ownerEmail, updatedAt: $updatedAt, isFollowed: $isFollowed)';
  }

  factory PinPin.fromJson(dynamic json) => _$PinPinFromJson(json);

  Map<String, dynamic> toJson() => _$PinPinToJson(this);
}
