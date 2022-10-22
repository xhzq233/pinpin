/// pinpin - bingding
/// Created by xhz on 2022/8/9
import 'package:get/get.dart';
import 'logic.dart';

class PPPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PPPostLogic());
  }
}
