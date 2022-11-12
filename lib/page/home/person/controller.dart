/// pinpin - controller
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';

class PPHomePersonController extends GetxController {
  void toEditProfilePage() {
    Get.toNamed(RN.edit_profile);
  }

  void toProfilePage() {
    Get.toNamed(RN.profile);
  }

  void toCollectionsPage() {
    Get.toNamed(RN.collections);
  }

  void toReleasesPage() {
    Get.toNamed(RN.releases);
  }

  void toGuidancePage() {
    Get.toNamed(RN.guidance);
  }

  void toAdvicePage() {
    Get.toNamed(RN.advice);
  }

  void logOut(BuildContext context) async {
    bool? delete = await showDeleteConfirmDialog(context);
    // if delete
  }

  Future<bool?> showDeleteConfirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: SizedBox(
              width: 250,
              height: 92,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Text(
                      "确认退出拼拼?",
                      style: AppTheme.headline4,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 36,
                            child: PPCommonTextButton(
                              style: PPCommonTextButtonStyle.outline,
                              title: "退出",
                              onPressed: () =>
                                  Navigator.of(context).pop(), // 关闭对话框
                            ),
                          )),

                      const SizedBox(width: 20),

                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 36,
                          child: PPCommonTextButton(
                            title: "再想想",
                            onPressed: () {
                              //关闭对话框并返回true
                              Navigator.of(context).pop(true);
                            },
                          ),
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void pressEditAvatar() {
    toEditProfilePage();
  }
}
