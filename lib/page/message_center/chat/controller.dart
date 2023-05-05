import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/model/message_chat/message_chat.dart';
import 'package:pinpin/model/message_chat/popup_choices.dart';

class ChatPageController extends GetxController {

  RxBool isMoreClick = false.obs;
  RxBool isCancelClick = false.obs;
  RxBool isDeleteClick = false.obs;
  RxString more = "assets/more.png".obs;
  RxString cancel = "assets/cancel.png".obs;
  RxString delete = "assets/delete.png".obs;

  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();


  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(id: 1, title: '举报用户!', iconPath: "assets/cancel.png"),
    PopupChoices(id: 2, title: '删除对话', iconPath: "assets/delete.png"),
  ];

  bool isShowLoading = false;
  final List<Message> _messages = [];
  List<Message> get messages  => _messages; // 当前聊天列表的信息

  @override
  void onInit() {
    for (int i = 0; i < 10; i++) {
      Message message = Message(
          uuid: i.toString(),
          type: MessageType.text,
          isSend: i % 2 == 0 ? true : false,
          msg: "hello,world, $i");
      _messages.add(message);
    }
    _messages.add(Message(
        uuid: Random.secure().nextInt(9999).toString(),
        type: MessageType.request,
        isSend: Random.secure().nextInt(9999) % 2 == 0 ? true : false,
        msg: "ddd"));
    super.onInit();
  }

  void addMessage(Message message) {
    _messages.add(message);
  }

  void onMoreClick() {
    isMoreClick(!isMoreClick.value);
    more(isMoreClick.value ? "assets/more_on_click.png" : "assets/more.png");
  }

  // 菜单点击事件
  void onCancelClick() {
    onMoreClick();
    isCancelClick(!isCancelClick.value);
    cancel(isCancelClick.value ? "assets/cancel_on_click.png": "assets/cancel.png");
  }

  // 菜单点击事件
  void onDeleteClick() {
    onMoreClick();
    isDeleteClick(!isDeleteClick.value);
    delete(isDeleteClick.value ? "assets/delete_on_click.png": "assets/delete.png");
  }
}