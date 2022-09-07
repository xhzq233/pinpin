// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply()
  ..Content = json['Content'] as String
  ..Created_at = json['Created_at'] as String
  ..Email = json['Email'] as String
  ..ID = json['ID'] as num
  ..IsDeleted = json['IsDeleted'] as bool
  ..IsThumbUp = json['IsThumbUp'] as bool
  ..PinpinId = json['PinpinId'] as num
  ..ReplyTo = json['ReplyTo'] as num
  ..ThumbUpNum = json['ThumbUpNum'] as num;

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'Content': instance.Content,
      'Created_at': instance.Created_at,
      'Email': instance.Email,
      'ID': instance.ID,
      'IsDeleted': instance.IsDeleted,
      'IsThumbUp': instance.IsThumbUp,
      'PinpinId': instance.PinpinId,
      'ReplyTo': instance.ReplyTo,
      'ThumbUpNum': instance.ThumbUpNum,
    };
