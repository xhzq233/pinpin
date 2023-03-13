import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';

import 'package:pinpin/page/login/login_base_page.dart';
import 'package:util/util.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginLogic>();
    return BaseLoginPage(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 42),
            child: Center(
              child: Text(
                "登陆1037拼拼",
                style: AppTheme.headline2,
              ),
            ),
          ),
          PPTextField(
            hintText: '输入学号',
            controller: controller.idTC,
            suffixText: '@hust.edu.cn',
            validator: controller.validators[0],
            onChanged: controller.onTextChanged,
          ),
          const SizedBox(
            height: 16,
          ),
          PPTextField(
            hintText: '输入密码',
            controller: controller.passwdTC,
            textFieldStyle: PPTextFieldStyle.obscure,
            validator: controller.validators[1],
            onChanged: controller.onTextChanged,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "忘记密码",
                style: AppTheme.headline6.copyWith(color: Colors.blue),
              ).onTap(controller.forgetPasswd),
              Text(
                "还未注册？",
                style: AppTheme.headline6.copyWith(color: Colors.blue),
              ).onTap(controller.toRegisterPage),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => PPCommonTextButton(
              title: '登陆',
              onPressed: controller.isLoginEnabled.value ? controller.onPressLogin : null,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
