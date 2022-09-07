import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice {
  Notice();

  late num ID;
  late String CreatedAt;
  late String UpdatedAt;
  late String? DeletedAt;
  late String? Title;
  late String? Content;
  late String? Email;
  late num? Timestamp;
  late bool IsRead;


  @override
  String toString() {
    return 'Notice{ID: $ID, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, DeletedAt: $DeletedAt, Title: $Title, Content: $Content, Email: $Email, Timestamp: $Timestamp, IsRead: $IsRead}';
  }

  factory Notice.fromJson(dynamic json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
