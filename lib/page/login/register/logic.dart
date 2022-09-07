import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';

class RegisterLogic extends GetxController {
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
