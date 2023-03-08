/// pinpin - controller
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/model/user_info/user_info.dart';

import '../../../manager/db_manager/pinpin_db.dart';

class PPHomePersonController extends GetxController {
  final _accountManager = Get.find<AccountManager>();
  final _http = Get.find<PPNetWorkInterface>();

  final Rx<UserInfo> userInfo = UserInfo.sample.obs;

  @override
  void onInit() {
    super.onInit();
    final account = _accountManager.current;
    if (null == account) return;
    ///这里加数据库拉取逻辑
    _http.getUserInfo(email: account.email).then((value) {
      if (value != null) {
        userInfo.value = value;
      }
    });
  }

  void toEditProfilePage() {
    Get.toNamed(RN.edit_profile);
  }

  void toProfilePage() {
    Get.toNamed(RN.profile, arguments: userInfo.value);
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
                                onPressed: () {
                                  if (_accountManager.isEmpty) return;

                                  // 移除账户
                                  _accountManager.removeAccountAt(_accountManager.currentIndex.value);
                                  _accountManager.setMainAccount(-1);
                                  // 跳转到欢迎页
                                  Get.offAllNamed(RN.welcome);
                                } // 关闭对话框
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
                          ))
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
