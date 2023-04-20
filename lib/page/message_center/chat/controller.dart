import 'package:get/get.dart';
import 'package:pinpin/model/message_chat/message_chat.dart';

class ChatPageController extends GetxController {
  // List<List<Message>>? mListMessage = [].obs as List<List<Message>>?;
  List<List<Message>>? mListMessage = [];
  RxBool isMoreClick = false.obs;

  void onMoreClick() {
    isMoreClick(!isMoreClick.value);
  }
}