
import 'package:get/get.dart';
import 'controller.dart';

class GuidanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuidanceController());
  }

}