import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordSetLogic extends GetxController {
  RxBool isPasswordVisible = false.obs;
  final passwdTC = TextEditingController();

  bool get isLoginEnabled => true;

  void onPressVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
