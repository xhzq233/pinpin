import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/util/validator.dart';

class LoginLogic extends GetxController {
  final idTC = TextEditingController();
  final passwdTC = TextEditingController();

  final List<Validator> validators = [
    Validators.studentID,
    Validators.passwd,
  ];

  RxBool isLoginEnabled = false.obs;

  void onTextChanged(String _) {
    isLoginEnabled.value = validators[0].call(idTC.text) == null && validators[1].call(passwdTC.text) == null;
  }

  void toRegisterPage() {
    Get.toNamed(RN.register);
  }

  void forgetPasswd() {
    Get.toNamed(RN.notFound);
  }

  void onPressLogin() {
    Get.offAllNamed(RN.home);
  }
}
