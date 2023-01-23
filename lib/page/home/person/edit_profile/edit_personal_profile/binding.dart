
import 'package:get/get.dart';
import 'controller.dart';

class EditPersonalProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPersonalProfileController());
  }

}