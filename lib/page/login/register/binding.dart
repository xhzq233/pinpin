import 'package:get/get.dart';
import 'package:pinpin/component/count_down/count_down_widget.dart';

import 'logic.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterLogic());
  }
}
