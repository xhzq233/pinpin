/// pinpin - api_interface
/// Created by xhz on 2022/7/27

import 'package:dio/dio.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';

mixin PPNetWorkInterface {
  Future<PinPinListData?> getPinPinData({
    required int type,
    required int label, // tag
    required int startTime,
    CancelToken? cancelToken,
  });
}