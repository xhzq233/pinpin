import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/util/validator.dart';

class PasswordSetLogic extends GetxController {
  RxBool isBtnEnabled = false.obs;

  Validator validator = Validators.passwd;

  void onTextChanged(String str) {
    isBtnEnabled.value = validator.call(str) == null;
  }
}
