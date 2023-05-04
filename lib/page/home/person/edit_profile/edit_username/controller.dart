
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pinpin/model/user_info/user_info.dart';


class EditUsernameController extends GetxController {

  final UserInfo? userInfo = Get.arguments;
  RxBool isKeyboardShowing = false.obs;
  late TextEditingController textEditingController;

  EditUsernameController(){
    textEditingController = TextEditingController(text: userInfo?.username);
  }

}