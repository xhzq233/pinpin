/// pinpin - logic
/// Created by xhz on 2022/8/9
import 'package:get/get.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:util/util.dart';

class PPDetailLogic extends GetxController {
  PPDetailLogic({required this.pp, required this.userInfo});

  final PinPin pp;
  final UserInfo userInfo;


  // delegates
  @override
  Future<bool> pressedFollow(int pinpinId) async {
    final res = await Get.find<PPNetWorkInterface>().followPinPin(pinPinId: pinpinId);

    // await Future.delayed(Duration(milliseconds: 200));
    if (null == res) return false;

    toast(res.msg);
    Logger.i(res.msg);
    return true;
  }
}
