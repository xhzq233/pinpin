import 'package:boxy/flex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import '../../../app/assets/name.dart';
import '../../../app/theme/app_theme.dart';
import '../../../component/stateful_button/pp_common_text_button.dart';
import 'logic.dart';

class LoginPage extends GetView<LoginLogic> {
  const LoginPage({Key? key}) : super(key: key);

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
                const Text(
                  "登陆1037拼拼",
                  style: AppTheme.headline2,
                ).centralized().paddingOnly(top: 20, bottom: 40),
                PPCommonTextButton(
                  title: '输入学号',
                  onPressed: () {},
                  style: PPCommonTextButtonStyle.outline,
                ).paddingAll(10),
                PPCommonTextButton(
                  title: '输入密码',
                  onPressed: () {},
                  style: PPCommonTextButtonStyle.outline,
                ).paddingAll(10),
                Text(
                  "*学号格式错误，请重新输入",
                  style:
                  AppTheme.headline9.copyWith(color: AppTheme.secondary1),
                ).paddingSymmetric(horizontal: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "忘记密码",
                      style: AppTheme.headline6.copyWith(color: Colors.blue),
                    ),
                    Text(
                      "已经注册？",
                      style: AppTheme.headline6.copyWith(color: Colors.blue),
                    ),
                  ],
                ).paddingAll(12),
                const PPCommonTextButton(
                  title: '登陆',
                ).paddingAll(10),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
