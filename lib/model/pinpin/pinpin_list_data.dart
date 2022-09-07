/// pinpin - pinpin_list_data
/// Created by xhz on 2022/7/28
import 'package:json_annotation/json_annotation.dart';
import 'pin_pin.dart';

part 'pinpin_list_data.g.dart';

@JsonSerializable(explicitToJson: true)
class PinPinListData {
  @JsonKey(name: 'Res')
  List<PinPin> data;
  @JsonKey(name: 'Latest')
  int latestTime;

  int? get next => latestTime == 0 ? null : latestTime;

  PinPinListData({
    required this.data,
    required this.latestTime,
  });

  @override
  String toString() {
    return 'PinPinListData{data: $data, latestTime: $latestTime}';
  }

  factory PinPinListData.fromJson(dynamic json) {
    return _$PinPinListDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PinPinListDataToJson(this);
}
