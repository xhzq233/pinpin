/// pinpin - pinpin
/// Created by xhz on 31/07/2022

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pinpin/manager/api/http_client.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'data_refreshable_list.dart';

class PinPinLoadMoreSource extends RefreshableListAdapter<PinPin, int> {
  final ppHttp = Get.find<PPHttp>();

  @override
  Future<List<PinPin>?> init(CancelToken cancelToken) => ppHttp
          .getPinPinData(
        type: -1,
        label: -1,
        startTime: -1,
        cancelToken: cancelToken,
      )
          .then((value) {
        nextDataPointer = value?.next;
        return value?.data;
      });

  @override
  Future<List<PinPin>?> next(CancelToken cancelToken) => ppHttp
          .getPinPinData(
        type: -1,
        label: -1,
        cancelToken: cancelToken,
        startTime: nextDataPointer!,
      )
          .then((value) {
        nextDataPointer = value?.next;
        return value?.data;
      });
}
