import 'package:boxy/flex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../component/stateful_button/pp_common_text_button.dart';
import 'logic.dart';

class PasswordPage extends GetView<PasswordLogic> {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: Colors.white,
      appBar: AppBar(
        title: Text(''),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxyColumn(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("设置密码", style: AppTheme.headline2)
                    .centralized()
                    .paddingOnly(top: 20, bottom: 40),
                PPCommonTextButton(
                  title: '输入密码',
                  onPressed: () {},
                  style: PPCommonTextButtonStyle.outline,
                ).paddingAll(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      AppAssets.passwd_hide,
                      scale: 2,
                    ).paddingSymmetric(horizontal: 2),
                    Text(
                      "隐藏密码",
                      style:
                      AppTheme.headline9.copyWith(color: AppTheme.banned),
                    )
                  ],
                ).paddingSymmetric(horizontal: 10),
                const PPCommonTextButton(
                  title: '加入',
                ).paddingAll(10),
                Text(
                  "*密码格式不合规范，需6-16个字符",
                  style:
                  AppTheme.headline9.copyWith(color: AppTheme.secondary1),
                ).paddingSymmetric(horizontal: 15),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
