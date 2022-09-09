// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice()
  ..id = json['ID'] ?? 0
  ..createdAt = json['CreatedAt'] ?? ""
  ..updatedAt = json['UpdatedAt'] ?? ""
  ..deletedAt = json['DeletedAt'] ?? ""
  ..title = json['Title'] ?? ""
  ..content = json['Content'] ?? ""
  ..email = json['Email'] ?? ""
  ..timeStamp = json['Timestamp'] ?? 0
  ..isRead = json['IsRead'] ?? false;

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'DeletedAt': instance.deletedAt,
      'Title': instance.title,
      'Content': instance.content,
      'Email': instance.email,
      'Timestamp': instance.timeStamp,
      'IsRead': instance.isRead,
    };
