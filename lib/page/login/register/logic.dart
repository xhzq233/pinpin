import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/util/validator.dart';

class RegisterLogic extends GetxController {
  Validator validator = Validators.studentID;
  RxBool isBtnEnabled = false.obs;

  void onTextChanged(String str) {
    isBtnEnabled.value = validator.call(str) == null;
  }

  void toLogin() {
    Get.toNamed(RN.login);
  }

  void appeal() {
    Get.toNamed(RN.notFound);
  }

  void next() {
    Get.toNamed(RN.passwd_set);
  }
}
