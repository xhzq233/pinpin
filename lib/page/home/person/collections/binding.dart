
import 'package:get/get.dart';
import 'controller.dart';

class CollectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectionsController());
  }

}