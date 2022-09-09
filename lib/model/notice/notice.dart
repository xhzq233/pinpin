import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice {
  Notice();
  @JsonKey(name: 'ID')
  late num id;
  @JsonKey(name: 'CreatedAt')
  late String createdAt;
  @JsonKey(name: 'UpdatedAt')
  late String updatedAt;
  @JsonKey(name: 'DeletedAt')
  late String deletedAt;
  @JsonKey(name: 'Title')
  late String title;
  @JsonKey(name: 'Content')
  late String content;
  @JsonKey(name: 'Email')
  late String email;
  @JsonKey(name: 'Timestamp')
  late num timeStamp;
  @JsonKey(name: 'IsRead')
  late bool isRead;


  @override
  String toString() {
    return 'Notice{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, title: $title, content: $content, email: $email, timeStamp: $timeStamp, isRead: $isRead}';
  }

  factory Notice.fromJson(dynamic json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
