/// pinpin - controller
/// Created by xhz on 07/08/2022
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/model/user_info/user_info.dart';

class PPHomePersonController extends GetxController {
  void toProfilePage() {
    Get.toNamed(RN.profile, arguments: userInfo.value);
  }

  final _accountManager = Get.find<AccountManager>();
  final _http = Get.find<PPNetWorkInterface>();

  final Rx<UserInfo> userInfo = UserInfo(
    background: 'https://xhzq.xyz/images/doge.png',
    history: [],
    image: 'https://xhzq.xyz/images/doge.png',
    brief: 'User brief',
    myTags: 'User tags',
    username: 'Username',
  ).obs;

  @override
  void onInit() {
    _http.getUserInfo(email: _accountManager.current!.email).then((value) {
      if (value != null) {
        userInfo.value = value;
      }
    });
    super.onInit();
  }

  void toXX() {}

  void pressEditAvatar() {}

  void logout() {
    if (_accountManager.isEmpty) return;

    _accountManager.removeAccountAt(_accountManager.currentIndex.value);
    _accountManager.setMainAccount(-1);
    Get.offAllNamed(RN.welcome);
  }
}
