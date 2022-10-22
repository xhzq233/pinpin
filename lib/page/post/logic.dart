/// pinpin - logic
/// Created by xhz on 2022/8/9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

class PPPostLogic extends GetxController {
  PPPostLogic();

  // data
  RxInt type = 0.obs;
  final TextEditingController title = TextEditingController();
  final TextEditingController summary = TextEditingController();
  final TextEditingController qty1 = TextEditingController();
  final TextEditingController qty2 = TextEditingController();
  final TextEditingController qtyInfo = TextEditingController();
  final TextEditingController teamInfo = TextEditingController();
  DateTime? ddl;

  final Rx<void Function()?> next = Rx(null);
  double maxHeight = 0.0;

  // max 3.0
  final RxDouble progress = RxDouble(0.0);

  final PageController pageController = PageController(initialPage: 0);


  final RxInt currentPage = 0.obs;

  @override
  void onInit() {
    pageController.addListener(onPageChanged);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.removeListener(onPageChanged);
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged() {
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
