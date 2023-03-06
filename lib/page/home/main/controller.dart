/// pinpin - controller
/// Created by xhz on 07/08/2022

import 'package:get/get.dart';
import 'package:pinpin/manager/load_more/pinpin.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

class PPHomeMainController extends GetxController {
  final entertainmentSource = PinPinLoadMoreSource(type: PinPin.ppt_ett);
  final studySource = PinPinLoadMoreSource(type: PinPin.ppt_study);


  RxInt selectedType = PinPin.ppt_ett.obs;
  RxInt selectedLabel = 0.obs;
}
