import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/component/count_down/count_down_widget.dart';
import 'package:pinpin/util/validator.dart';

class RegisterLogic extends GetxController {
  RxBool btnEnabled = false.obs;

  final CountDownController countDownController = Get.put(CountDownController());
  final idTC = TextEditingController();
  final codeTC = TextEditingController();
  bool idValid = false;
  bool codeValid = false;

  set enableCountDown(bool newValue) {
    if (countDownController.banned == newValue) {
      countDownController.banned = !newValue;
      countDownController.update();
    }
  }

  void onIDChanged(String str) {
    idValid = Validators.studentID.call(str) == null;

    // enableCountDown when idValid
    enableCountDown = idValid;

    btnEnabled.value = idValid && codeValid;
  }

  void onCodeChanged(String str) {
    codeValid = Validators.verifyCode.call(str) == null;
    btnEnabled.value = idValid && codeValid;
  }

  void toLogin() {
    Get.offNamed(RN.login);
  }

  void appeal() {
    Get.toNamed(RN.notFound);
  }

  void next() {
    Get.toNamed(RN.passwd_set);
  }
}
