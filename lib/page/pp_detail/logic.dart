/// pinpin - logic
/// Created by xhz on 2022/8/9
import 'package:get/get.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/model/user_info/user_info.dart';

class PPDetailLogic extends GetxController {
  PPDetailLogic({required this.pp, required this.userInfo});

  final PinPin pp;
  final UserInfo userInfo;
}
