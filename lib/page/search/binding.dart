
import 'package:get/get.dart';
import 'controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PPSearchController());
  }

}