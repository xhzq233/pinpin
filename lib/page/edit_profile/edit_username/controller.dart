
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pinpin/model/user_info/user_info.dart';


class EditUsernameController extends GetxController {

  final UserInfo? userInfo = Get.arguments;
  RxBool isKeyboardShowing = false.obs;
  TextEditingController? controller;

  EditUsernameController(){
    controller = TextEditingController(text: userInfo!.username);
  }

}