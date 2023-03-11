/// pinpin - controller
/// Created by xhz on 07/08/2022

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/manager/load_more/pinpin.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

class PPHomeMainController extends GetxController {
  final Map<int, Map<int, PinPinLoadMoreSource>> _sources = {PinPin.ppt_ett: {}, PinPin.ppt_study: {}};

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
}
