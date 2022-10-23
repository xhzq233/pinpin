import 'package:get/get.dart';

import 'logic.dart';

class PasswordSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordSetLogic());
  }
}