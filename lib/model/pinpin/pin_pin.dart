import 'package:flutter/foundation.dart';

class PinPin {
  int pinpinId;
  int type;
  int label;
  String title;
  DateTime deadline;
  int demandingNum;
  int nowNum;
  String ownerEmail;
  int updatedAt;
  bool isFollowed;

  PinPin({
    required this.pinpinId,
    required this.type,
    required this.label,
    required this.title,
    required this.deadline,
    required this.demandingNum,
    required this.nowNum,
    required this.ownerEmail,
    required this.updatedAt,
    required this.isFollowed,
  });

  @override
  String toString() {
    return 'PinPin(pinpinId: $pinpinId, type: $type, label: $label, title: $title, deadline: $deadline, demandingNum: $demandingNum, nowNum: $nowNum, ownerEmail: $ownerEmail, updatedAt: $updatedAt, isFollowed: $isFollowed)';
  }

  // {
  //     "PinpinId": 1,
  //     "Type": 1,
  //     "Label": 14,
  //     "Title": "去酒吧看球",
  //     "Deadline": "2022-07-22T08:42:25.107Z",
  //     "DemandingNum": 10,
  //     "NowNum": 3,
  //     "OwnerEmail": "U202015583",
  //     "UpdatedAt": 1655703125,
  //     "IsFollowed": false
  // }

  factory PinPin.fromJson(Map<String, dynamic> json) => PinPin(
        pinpinId: json['PinpinId'],
        type: json['Type'],
        label: json['Label'],
        title: json['Title'],
        deadline: DateTime.parse(json['Deadline']),
        demandingNum: json['DemandingNum'],
        nowNum: json['NowNum'],
        ownerEmail: json['OwnerEmail'],
        updatedAt: json['UpdatedAt'],
        isFollowed: json['IsFollowed'],
      );

  Map<String, dynamic> toJson() => {
        'PinpinId': pinpinId,
        'Type': type,
        'Label': label,
        'Title': title,
        'Deadline': deadline.toIso8601String(),
        'DemandingNum': demandingNum,
        'NowNum': nowNum,
        'OwnerEmail': ownerEmail,
        'UpdatedAt': updatedAt,
        'IsFollowed': isFollowed,
      };

  PinPin copyWith({
    int? pinpinId,
    int? type,
    int? label,
    String? title,
    DateTime? deadline,
    int? demandingNum,
    int? nowNum,
    String? ownerEmail,
    int? updatedAt,
    bool? isFollowed,
  }) {
    return PinPin(
      pinpinId: pinpinId ?? this.pinpinId,
      type: type ?? this.type,
      label: label ?? this.label,
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      demandingNum: demandingNum ?? this.demandingNum,
      nowNum: nowNum ?? this.nowNum,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      updatedAt: updatedAt ?? this.updatedAt,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PinPin) return false;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      pinpinId.hashCode ^
      type.hashCode ^
      label.hashCode ^
      title.hashCode ^
      deadline.hashCode ^
      demandingNum.hashCode ^
      nowNum.hashCode ^
      ownerEmail.hashCode ^
      updatedAt.hashCode ^
      isFollowed.hashCode;
}
