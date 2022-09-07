// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice()
  ..ID = json['ID'] as num
  ..CreatedAt = json['CreatedAt'] as String
  ..UpdatedAt = json['UpdatedAt'] as String
  ..DeletedAt = json['DeletedAt'] as String?
  ..Title = json['Title'] as String?
  ..Content = json['Content'] as String?
  ..Email = json['Email'] as String?
  ..Timestamp = json['Timestamp'] as num?
  ..IsRead = json['IsRead'] as bool;

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'ID': instance.ID,
      'CreatedAt': instance.CreatedAt,
      'UpdatedAt': instance.UpdatedAt,
      'DeletedAt': instance.DeletedAt,
      'Title': instance.Title,
      'Content': instance.Content,
      'Email': instance.Email,
      'Timestamp': instance.Timestamp,
      'IsRead': instance.IsRead,
    };
