
import 'package:get/get.dart';
import 'controller.dart';

class AdviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdviceController());
  }

}