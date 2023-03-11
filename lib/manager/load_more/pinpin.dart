import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'data_refreshable_list.dart';

class PinPinLoadMoreSource extends RefreshableListAdapter<PinPin, int> {
  PinPinLoadMoreSource({
    required this.type,
    required this.label,
  });

  final ppHttp = Get.find<PPNetWorkInterface>();

  final int type;

  final int label;

  @override
  Future<List<PinPin>?> init(CancelToken cancelToken) =>
      ppHttp.getPinPinData(type: type, label: label, startTime: -1, cancelToken: cancelToken).then((value) {
        if (null != value) {
          nextDataPointer = value.next;
          return value.data;
        }
        return null;
      });

  @override
  Future<List<PinPin>?> next(CancelToken cancelToken) =>
      ppHttp.getPinPinData(type: type, label: label, cancelToken: cancelToken, startTime: nextDataPointer!).then(
        (value) {
          nextDataPointer = value?.next;
          return value?.data;
        },
      );
}
