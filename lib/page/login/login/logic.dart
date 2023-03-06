import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/component/loading/loading.dart';

import 'package:pinpin/manager/api/api_interface.dart';
import 'package:util/util.dart';

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
    Get.offNamed(RN.register);
  }

  void forgetPasswd() {
    Get.toNamed(RN.notFound);
  }

  final _http = Get.find<PPNetWorkInterface>();

  void onPressLogin() async {
    Loading.show();
    final res = await _http.signIn(email: idTC.text, password: passwdTC.text);

    if (null != res) {
      toast('Login Success');
      Get.offAllNamed(RN.home);
    }
    Loading.hide();
  }
}
