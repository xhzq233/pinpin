import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginLogic>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PPNavigationBar(),
        body: AutoUnFocusWrap(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
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
                textFieldStyle: PPTextFieldStyle.outline,
              ),
              Obx(() => PPTextField(
                    hintText: '输入密码',
                    onPressVisible: controller.onPressVisible,
                    isPasswordVisible: controller.isPasswordVisible.value,
                    controller: controller.passwdTC,
                    textFieldStyle: PPTextFieldStyle.obscure,
                  )),
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
              PPCommonTextButton(
                title: '登陆',
                onPressed: controller.isLoginEnabled ? controller.onPressLogin : null,
              ),
              const Flexible(
                  child: SizedBox(
                height: 400,
              ))
            ],
          ).paddingSymmetric(horizontal: 30),
        ));
  }
}
