part of 'reply_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyListData _$ReplyListDataFromJson(Map<String, dynamic> json) =>
    ReplyListData(
      data: (json['data'] as List<dynamic>)
          .map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReplyListDataToJson(ReplyListData instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };