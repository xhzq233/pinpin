import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/component/count_down/count_down_widget.dart';
import 'package:pinpin/component/loading/loading.dart';
import 'package:pinpin/component/toast/toast.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/util/validator.dart';

class RegisterLogic extends GetxController {
  RxBool btnEnabled = false.obs;

  late final CountDownController countDownController = Get.find<CountDownController>()..sendCode = sendCode;

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

  final _http = Get.find<PPNetWorkInterface>();

  Future<bool> sendCode() =>
      _http.sendVerifyCode(email: idTC.text, isResetPassword: false).then((value) => value != null);

  void onIDChanged(String str) {
    idValid = Validators.studentID.call(str) == null;

    // enableCountDown when idValid
    enableCountDown = idValid;
    _refreshValidValue();
  }

  void onCodeChanged(String str) {
    codeValid = Validators.verifyCode.call(str) == null;
    _refreshValidValue();
  }

  void _refreshValidValue() {
    btnEnabled.value = idValid && codeValid;
  }

  void toLogin() {
    Get.offNamed(RN.login);
  }

  void appeal() {
    Get.toNamed(RN.notFound);
  }

  void next() async {
    Loading.show();
    final res = await _http.activateAccount(email: idTC.text, verifyCode: codeTC.text);
    Loading.hide();
    if (null != res) {
      toast(res.msg);
      Get.toNamed(RN.passwd_set, arguments: idTC.text);
    }
  }
}
