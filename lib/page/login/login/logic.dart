import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';

class LoginLogic extends GetxController {
  final idTC = TextEditingController();
  final passwdTC = TextEditingController();

  RxBool isPasswordVisible = false.obs;

  bool get isLoginEnabled => true;

  void toRegisterPage() {
    Get.toNamed(RN.register);
  }

  void forgetPasswd() {
    Get.toNamed(RN.notFound);
  }

  void onPressLogin() {
    Get.offAllNamed(RN.home);
  }

  void onPressVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
