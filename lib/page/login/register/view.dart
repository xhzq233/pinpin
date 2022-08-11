import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/page/login/register/logic.dart';

import '../../../app/assets/name.dart';
import '../../../app/theme/app_theme.dart';
import '../../../component/stateful_button/pp_common_text_button.dart';

class RegisterPage extends GetView<RegisterLogic> {
  const RegisterPage({Key? key}) : super(key: key);

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
                  "注册1037拼拼",
                  style: AppTheme.headline2,
                ).centralized().paddingOnly(top: 20, bottom: 40),
                PPCommonTextButton(
                  title: '输入学号',
                  onPressed: () {},
                  style: PPCommonTextButtonStyle.outline,
                ).paddingAll(10),
                const PPCommonTextButton(
                  title: '下一步',
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
                      "学号被占用？点击申诉",
                      style: AppTheme.headline6.copyWith(color: Colors.blue),
                    ),
                    Text(
                      "已经注册？",
                      style: AppTheme.headline6.copyWith(color: Colors.blue),
                    ),
                  ],
                ).paddingAll(12),
                Text(
                  "1037拼拼会向您的华科校园邮箱发送邮件验证校园身份，您可稍后再进行验证。",
                  style: AppTheme.headline9.copyWith(color: AppTheme.banned),
                ).paddingSymmetric(horizontal: 12),
              ],
            ).paddingSymmetric(horizontal: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "注册账号即表示您同意",
                    style: AppTheme.headline6.copyWith(color: AppTheme.banned),
                  ),
                  TextSpan(
                    text: "《使用协议》",
                    style: AppTheme.headline6.copyWith(color: Colors.blue),
                  ),
                  TextSpan(
                    text: "和",
                    style: AppTheme.headline6.copyWith(color: AppTheme.banned),
                  ),
                  TextSpan(
                    text: "《隐私条款》",
                    style: AppTheme.headline6.copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ).paddingAll(12),
          ],
        ),
      ),
    );
  }
}
