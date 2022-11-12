
import 'package:get/get.dart';
import 'controller.dart';

class EditUsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditUsernameController());
  }

}