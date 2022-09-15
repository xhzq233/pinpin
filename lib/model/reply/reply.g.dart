// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply()
  ..content = json['Content'] ?? ""
  ..createdAt = json['Created_at'] ?? ""
  ..email = json['Email']  ?? ""
  ..id = json['ID'] as num
  ..isDeleted = json['IsDeleted'] as bool
  ..isThumbUp = json['IsThumbUp'] as bool
  ..pinPinId = json['PinpinId'] as num
  ..replyTo = json['ReplyTo'] as num
  ..thumbUpNum = json['ThumbUpNum'] as num;

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'Content': instance.content,
      'Created_at': instance.createdAt,
      'Email': instance.email,
      'ID': instance.id,
      'IsDeleted': instance.isDeleted,
      'IsThumbUp': instance.isDeleted,
      'PinpinId': instance.pinPinId,
      'ReplyTo': instance.replyTo,
      'ThumbUpNum': instance.thumbUpNum,
    };
