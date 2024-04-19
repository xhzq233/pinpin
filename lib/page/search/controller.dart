import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/manager/load_more/pinpin.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:util/toast/toast.dart';

enum Status {
  initial,
  hint,
  result,
  error
}
class PPSearchController extends GetxController with PPHomeCardViewDelegate {

  final _http = Get.find<PPNetWorkInterface>();
  final Map<int, Map<int, PinPinLoadMoreSource>> _sources = {PinPin.ppt_ett: {}, PinPin.ppt_study: {}};
  RxList<PinPin> pinpins = RxList();
  final Rx<Status> _status = Status.initial.obs;
  Rx<Status> get status => _status;

  void handleSearchPinPin(String title) async {
    _status(Status.hint);
    final result = await _http.searchPinPinData(title: title, label: -1, startTime: -1);
    if(result != null) {
      pinpins(result.data);
    }
  }

  void setStatus(Status status) {
    _status(status);
  }

  PinPinLoadMoreSource getSource(int type) {
    final selectedLabel = AppAssets.labelArray[type]![selectedLabelIndex[type]!.value].id;
    var res = _sources[type]![selectedLabel];
    if (null == res) {
      _sources[type]![selectedLabel] = PinPinLoadMoreSource(type: type, label: selectedLabel);
      _sources[type]![selectedLabel]!.refresh(true); //如果是新的就要reload页面并刷新数据
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        res.onStateChanged(res); //单纯reload页面
      });
    }
    return _sources[type]![selectedLabel]!;
  }

  Map<int, RxInt> selectedLabelIndex = {PinPin.ppt_study: 0.obs, PinPin.ppt_ett: 0.obs};

  // delegates
  @override
  Future<bool> pressedFollow(int pinpinId) async {
    final res = await Get.find<PPNetWorkInterface>().followPinPin(pinPinId: pinpinId);

    // await Future.delayed(Duration(milliseconds: 200));
    if (null == res) return false;

    toast(res.msg);
    return true;
  }

}