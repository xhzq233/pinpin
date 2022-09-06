import 'package:get/get.dart';

import 'logic.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeLogic());
  }
}
