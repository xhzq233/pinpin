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
    // more info
    this.createdAt,
    this.demandingDescription,
    this.description,
    this.isDeleted,
    this.replyNum,
    this.teamIntroduction,
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
  String? description;

  @JsonKey(name: "DemandingDescription")
  String? demandingDescription;

  @JsonKey(name: "TeamIntroduction")
  String? teamIntroduction;

  @JsonKey(name: "IsDeleted")
  bool? isDeleted;

  @JsonKey(name: "CreatedAt")
  int? createdAt;

  @JsonKey(name: "ReplyNum")
  int? replyNum;

  @override
  String toString() {
    return 'PinPin(pinpinId: $pinpinId, type: $type, label: $label, title: $title, deadline: $deadline, demandingNum: $demandingNum, nowNum: $nowNum, ownerEmail: $ownerEmail, updatedAt: $updatedAt, isFollowed: $isFollowed)';
  }

  factory PinPin.fromJson(dynamic json) => _$PinPinFromJson(json);

  Map<String, dynamic> toJson() => _$PinPinToJson(this);
}
