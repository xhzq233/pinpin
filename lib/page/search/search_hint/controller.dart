import 'package:get/get.dart';
import 'package:pinpin/page/search/controller.dart';

class SearchHintController extends GetxController {
  final searchController = Get.find<PPSearchController>();

  void handleSearchPinPin(String title) {
    searchController.handleSearchPinPin(title);
    searchController.setStatus(Status.result);
  }
}