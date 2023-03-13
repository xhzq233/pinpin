import 'package:get/get.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/model/account/account.dart';
import 'package:pinpin/model/user_info/user_info.dart';

class ReleasesController extends GetxController {
  final _accountManager = Get.find<AccountManager>();
  final _http = Get.find<PPNetWorkInterface>();
  late Account account;

  final Rx<UserInfo> userInfo = UserInfo.sample.obs;

  @override
  void onInit() {
    super.onInit();
    account = _accountManager.current!;

    _http.getUserInfo(email: account.email).then((value) {
      if (value != null) {
        userInfo.value = value;
      }
    });
  }

  void deletePinPin(int id) {
    _http.deletePinpin(pinPinId: id).then(
          (value) => {
            if (value!.msg == "ok")
              {
                _http.getUserInfo(email: account.email).then((value) {
                  if (value != null) {
                    userInfo.value = value;
                  }
                })
              }
          },
        );
  }
}
