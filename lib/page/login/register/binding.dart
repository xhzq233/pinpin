import 'package:get/get.dart';

import 'logic.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterLogic());
  }
}
