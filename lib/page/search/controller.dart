import 'package:get/get.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

enum Status {
  initial,
  hint,
  result,
  error
}
class SearchController extends GetxController {

  final _http = Get.find<PPNetWorkInterface>();
  RxList<PinPin> pinpins = RxList();
  Rx<Status> _status = Status.initial.obs;
  Rx<Status> get status => _status;

  void handleSearchPinPin(String title) async {
    _status(Status.hint);
    final result = await _http.searchPinPinData(title: title, label: -1, startTime: -1);
    if(result != null) {
      pinpins(result.data);
    }
  }

  void setStatus(Status status) {
    _status(status);
  }

}