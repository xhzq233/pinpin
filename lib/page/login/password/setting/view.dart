import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/page/login/login_base_page.dart';

import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'logic.dart';

class PasswordSetPage extends GetView<PasswordSetLogic> {
  const PasswordSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLoginPage(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("设置密码", style: AppTheme.headline2).centralized().paddingOnly(top: 20, bottom: 40),
          Obx(() => PPTextField(
            hintText: '输入密码',
            onPressVisible: controller.onPressVisible,
            isPasswordVisible: controller.isPasswordVisible.value,
            controller: controller.passwdTC,
            textFieldStyle: PPTextFieldStyle.obscure,
          )),
          const PPCommonTextButton(
            title: '加入',
          ),
          Text(
            "*密码格式不合规范，需6-16个字符",
            style: AppTheme.headline9.copyWith(color: AppTheme.secondary1),
          ),
          const Flexible(
            child: SizedBox(
              height: 400,
            ),
          ),
        ],
      ),
    );
  }
}
