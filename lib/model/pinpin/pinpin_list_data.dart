/// pinpin - pinpin_list_data
/// Created by xhz on 2022/7/28
import 'pin_pin.dart';

class PinPinListData {
  List<PinPin> data;
  int? latestTime;

  PinPinListData({
    required this.data,
    this.latestTime,
  });

  factory PinPinListData.fromJson(dynamic json) => PinPinListData(
      latestTime: json['latest'] == 0 ? null : json['latest'],
      //means nothing when latestTime is zero
      data: (json['msg'] as Iterable).map((e) => PinPin.fromJson(e)).toList());
}
