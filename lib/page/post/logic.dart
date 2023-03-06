/// pinpin - logic
/// Created by xhz on 2022/8/9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/loading/loading.dart';
import 'package:pinpin/component/page_view/page_view.dart';

import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:util/util.dart';

const _kMaxDuration = Duration(days: 60);

class PPPostLogic extends GetxController {
  PPPostLogic();

  // data
  RxInt selectedType = PinPin.ppt_ett.obs;
  RxInt selectedLabel = 0.obs;
  final TextEditingController title = TextEditingController();
  final TextEditingController summary = TextEditingController();
  final TextEditingController qty1 = TextEditingController();
  final TextEditingController qty2 = TextEditingController();
  final TextEditingController qtyInfo = TextEditingController();
  final TextEditingController teamInfo = TextEditingController();
  DateTime? ddl;

  // ui control
  bool titleValid = false;
  bool qtyValid = false;
  bool ddlValid = false;

  final Rx<void Function()?> next = Rx(null);
  double maxHeight = 0.0;

  // max 3
  final RxInt progress = RxInt(0);

  final CachePageController pageController = CachePageController(initialPage: 0);

  final RxInt currentPage = 0.obs;

  // methods
  final ppHttp = Get.find<PPNetWorkInterface>();

  void _post() async {
    Loading.show();
    final res = await ppHttp.createPinpin(
      title: title.text,
      //TODO
      label: AppAssets.label_array[selectedType.value]![selectedLabel.value].id,
      type: selectedType.value,
      description: summary.text,
      deadline: ddl!.toUtc().toIso8601String(),
      demandingNum: int.parse(qty1.text),
      nowNum: int.parse(qty2.text),
      demandingDescription: qtyInfo.text,
      teamIntroduction: teamInfo.text,
    );
    Loading.hide();

    if (null != res) {
      toast('Post Success');
      Get.back();
    }
  }

  @override
  void onInit() {
    pageController.addListener(_onPageChanged);
    title.addListener(_onTitleChanged);
    qty1.addListener(_onQtyChanged);
    qty2.addListener(_onQtyChanged);

    super.onInit();
  }

  @override
  void onClose() {
    pageController.removeListener(_onPageChanged);
    pageController.dispose();

    title.removeListener(_onTitleChanged);
    qty1.removeListener(_onQtyChanged);
    qty2.removeListener(_onQtyChanged);

    title.dispose();
    summary.dispose();
    qty1.dispose();
    qty2.dispose();
    qtyInfo.dispose();
    teamInfo.dispose();

    super.onClose();
  }

  void _onTitleChanged() {
    titleValid = title.text.isNotEmpty;

    _refreshValidValue();
  }

  void _onQtyChanged() {
    qtyValid = qty1.text.isNotEmpty && qty2.text.isNotEmpty && (int.parse(qty1.text) > int.parse(qty2.text));

    _refreshValidValue();
  }

  void pickDll(BuildContext refresher) async {
    final now = DateTime.now();
    final newDDL = await showDatePicker(
      context: refresher,
      initialDate: ddl ?? now,
      firstDate: now,
      lastDate: now.add(_kMaxDuration),
    );

    if (null != newDDL) {
      ddlValid = true;
    } else {
      ddlValid = false;
    }

    if (newDDL != ddl) {
      // change ui only when data changed
      ddl = newDDL;
      (refresher as Element).markNeedsBuild();
    }

    _refreshValidValue();
  }

  void _refreshValidValue() {
    progress.value = titleValid.intValue + qtyValid.intValue + ddlValid.intValue;
    next.value = titleValid && qtyValid && ddlValid ? _post : null;
  }

  void _onPageChanged() {
    final page = pageController.page!;
    if (page < 0.6) {
      currentPage.value = 0;
    } else if (0.6 < page && page < 1.4) {
      currentPage.value = 1;
    } else {
      currentPage.value = 2;
    }
  }
}
