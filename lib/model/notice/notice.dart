import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice {
  Notice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.content,
    required this.email,
    required this.timeStamp,
    required this.isRead,
  });

  @JsonKey(name: 'ID')
  int id;
  @JsonKey(name: 'CreatedAt')
  String createdAt;
  @JsonKey(name: 'UpdatedAt')
  String updatedAt;
  @JsonKey(name: 'DeletedAt')
  String deletedAt;
  @JsonKey(name: 'Title')
  String title;
  @JsonKey(name: 'Content')
  String content;
  @JsonKey(name: 'Email')
  String email;
  @JsonKey(name: 'Timestamp')
  int timeStamp;
  @JsonKey(name: 'IsRead')
  bool isRead;

  @override
  String toString() {
    return 'Notice{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, title: $title, content: $content, email: $email, timeStamp: $timeStamp, isRead: $isRead}';
  }

  factory Notice.fromJson(dynamic json) => _$NoticeFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
