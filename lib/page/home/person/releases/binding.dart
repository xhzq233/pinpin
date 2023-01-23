
import 'package:get/get.dart';
import 'controller.dart';

class ReleasesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReleasesController());
  }

}