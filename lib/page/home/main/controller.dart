/// pinpin - controller
/// Created by xhz on 07/08/2022

import 'package:get/get.dart';
import 'package:pinpin/model/load_more/pinpin.dart';

class PPHomeMainController extends GetxController {
  final source = PinPinLoadMoreSource(type: 1);
  final source2 = PinPinLoadMoreSource(type: 2);
}
