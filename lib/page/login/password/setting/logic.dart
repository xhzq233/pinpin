import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/component/loading/loading.dart';
import 'package:pinpin/component/toast/toast.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/util/validator.dart';

class PasswordSetLogic extends GetxController {
  Rx<VoidCallback?> next = Rx<VoidCallback?>(null);

  Validator validator = Validators.passwd;

  PasswordSetLogic({this.reset = false});

  final passwd = TextEditingController();
  final bool reset;

  final _http = Get.find<PPNetWorkInterface>();
  late final String email = Get.arguments;

  void onTextChanged(String str) {
    next.value = validator.call(str) == null ? _finish : null;
  }

  void _finish() async {
    Loading.show();
    if (reset) {
      // ppHttp.changePassword(email: 'email', verifyCode: 'verifyCode', newPassword: 'newPassword');
    } else {
      final res = await _http.createUser(
          email: email, username: 'user_$email', password: passwd.text, img: 'https://xhzq.xyz/images/doge.png');

      if (null != res) {
        final res = await _http.signIn(email: email, password: passwd.text);
        if (null != res) {
          toast('Login Success');
          Get.offAllNamed(RN.home);
        }
      }
    }
    Loading.hide();
  }
}
