// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinpin_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinPinListData _$PinPinListDataFromJson(Map<String, dynamic> json) =>
    PinPinListData(
      data: (json['data']['Res'] as List<dynamic>)
          .map((e) => PinPin.fromJson(e as Map<String, dynamic>))
          .toList(),
      latestTime: json['data']['Latest'] as int,
    );

Map<String, dynamic> _$PinPinListDataToJson(PinPinListData instance) =>
    <String, dynamic>{
      'Res': instance.data.map((e) => e.toJson()).toList(),
      'Latest': instance.latestTime,
    };
