
import 'package:get/get.dart';
import 'controller.dart';

class EditLabelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditLabelsController());
  }

}