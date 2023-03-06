/// pinpin - bingding
/// Created by xhz on 2022/8/9
import 'package:get/get.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'logic.dart';

class PPDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PPDetailLogic(pp: Get.arguments, userInfo: UserInfo.sample));
  }
}
