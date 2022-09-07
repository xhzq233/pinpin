import 'package:flutter/foundation.dart';

class HistoryPinPin {
  int pinpinId;
  int type;
  int label;
  String title;
  DateTime deadline;
  int demandingNum;
  int nowNum;
  int replyNum;
  String ownerEmail;
  int updatedAt;
  int createdAt;
  bool? isDeleted;
  String? demandingDescription;
  String?teamIntroduction;
  String? description;



  HistoryPinPin({
    required this.pinpinId,
    required this.type,
    required this.label,
    required this.title,
    required this.deadline,
    required this.demandingNum,
    required this.nowNum,
    required this.ownerEmail,
    required this.updatedAt,
    required this.isDeleted,
    required this.description,
    required this.demandingDescription,
    required this.teamIntroduction,
    required this.createdAt,
    required this.replyNum
  });


  @override
  String toString() {
    return 'PinPin{pinpinId: $pinpinId, type: $type, label: $label, title: $title, deadline: $deadline, demandingNum: $demandingNum, nowNum: $nowNum, replyNum: $replyNum, ownerEmail: $ownerEmail, updatedAt: $updatedAt, createAt: $createdAt, isDeleted: $isDeleted, demandingDescription: $demandingDescription, teamIntroduction: $teamIntroduction, description: $description}';
  }

  factory HistoryPinPin.fromJson(dynamic json) => HistoryPinPin(
    pinpinId: json['PinpinId'] ?? 0,
    type: json['Type'] ?? 0,
    label: json['Label'] ?? 0,
    title: json['Title'] ?? "",
    deadline: DateTime.parse(json['Deadline'] ?? "2022-07-26T16:57:35.107Z"),
    demandingNum: json['DemandingNum'] ?? 0,
    nowNum: json['NowNum'] ?? 0,
    ownerEmail: json['OwnerEmail'] ?? "",
    updatedAt: json['UpdatedAt'] ?? 0,
    createdAt: json['CreatedAt'] ?? 0,
    isDeleted: json['isDeleted'] ?? false,
    teamIntroduction: json['TeamIntroduction'],
    demandingDescription: json['DemandingDescription'],
    replyNum: json['ReplyNum'] ?? 0,
    description:json['Description'],
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
    'CreatedAt': createdAt,
    'IsFollowed': isDeleted,
    'ReplyNum': replyNum,
    'description': description,
    'TeamIntroduction': teamIntroduction,
    'DemandingDescription': demandingDescription
  };

  HistoryPinPin copyWith({
    int? pinpinId,
    int? type,
    int? label,
    String? title,
    DateTime? deadline,
    int? demandingNum,
    int? nowNum,
    String? ownerEmail,
    int? updatedAt,
    bool? isDeleted,
    int? replyNum,
    String? description,
    String? teamIntroduction,
    String? demandingDescription,
    int? createdAt,
  }) {
    return HistoryPinPin(
      pinpinId: pinpinId ?? this.pinpinId,
      type: type ?? this.type,
      label: label ?? this.label,
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      demandingNum: demandingNum ?? this.demandingNum,
      nowNum: nowNum ?? this.nowNum,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      replyNum: replyNum ?? this.replyNum,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      demandingDescription: demandingDescription ?? this.demandingDescription,
      teamIntroduction: teamIntroduction ?? this.teamIntroduction,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! HistoryPinPin) return false;
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
      replyNum.hashCode ^
      ownerEmail.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode ^
      isDeleted.hashCode ^
      demandingDescription.hashCode ^
      teamIntroduction.hashCode ^
      description.hashCode;
}
