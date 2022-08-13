// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      background: json['data']['Background'] as String,
      history: (json['data']['History'] as List<dynamic>)
          .map((e) => PinPin.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['data']['Image'] as String,
      masterIntroduction: json['data']['MasterIntroduction'] as String,
      myTags:
          (json['data']['MyTags'] as List<dynamic>).map((e) => e as String).toList(),
      username: json['data']['Username'] as String,
    )
      ..token = json['data']['token'] as String?
      ..id = json['data']['id'] as int;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'Background': instance.background,
      'History': instance.history.map((e) => e.toJson()).toList(),
      'Image': instance.image,
      'MasterIntroduction': instance.masterIntroduction,
      'MyTags': instance.myTags,
      'Username': instance.username,
      'token': instance.token,
      'id': instance.id,
    };
