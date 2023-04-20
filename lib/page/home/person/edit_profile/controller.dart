import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/component/bottom_sheet/bottom_sheet_factory.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:pinpin/page/home/person/controller.dart';

class EditProfileController extends GetxController {
  final personController = Get.find<PPHomePersonController>();
  final UserInfo? userInfo = Get.arguments;

  XFile? pickedFile;
  final imageFile = File("").obs;

  final isShowBottomSheet = false.obs;
  int count = 0;
  RxBool switchValue = RxBool(false);

  void toEditPersonalProfilePage() {
    Get.toNamed(RN.edit_personal_profile, arguments: userInfo);
  }

  void toEditUsernamePage() {
    Get.toNamed(RN.edit_username, arguments: userInfo);
  }

  void toEditLabelsPage() {
    Get.toNamed(RN.edit_labels, arguments: userInfo);
  }

  void onClickShowOrNotButton() {
    switchValue(!switchValue.value);
  }

  void onChangeAvatar(BuildContext context) async {
    final names = ["选择照片", "拍照"];
    await _showBottomSheet(context, names);
  }

  Future<int?> _showBottomSheet(context, List<String> options) async {
    return BottomSheetFactory.showBottomSheet(context, options,
        onFirstTap: (value) {
      pickedFile = value as XFile;
      imageFile(File(pickedFile!.path));
    }, onSecondTap: (value) {
      pickedFile = value as XFile;
      imageFile(File(pickedFile!.path));
    });
  }
}
