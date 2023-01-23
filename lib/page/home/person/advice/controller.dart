import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class AdviceController extends GetxController{

  RxBool isKeyboardShowing = false.obs;

  final TextEditingController etController = TextEditingController(text: "提示：寻求更多建议与反馈。向我们团队给出更多的想法吧。（最多输入200字）");
}