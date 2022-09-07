import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/page/login/register/logic.dart';
import '../../../app/theme/app_theme.dart';
import '../../../component/stateful_button/pp_common_text_button.dart';

class RegisterPage extends GetView<RegisterLogic> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "注册1037拼拼",
                  style: AppTheme.headline2,
                ),
              ),
            ),
            PPTextField(
              hintText: '输入学号',
              textFieldStyle: PPTextFieldStyle.outline,
            ),
            const PPCommonTextButton(
              title: '下一步',
            ),
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
            ),
            Text(
              "1037拼拼会向您的华科校园邮箱发送邮件验证校园身份，您可稍后再进行验证。",
              style: AppTheme.headline9.copyWith(color: AppTheme.banned),
            ),
            const Flexible(
              child: SizedBox(
                height: 340,
              ),
            ),
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
            ),
          ],
        ).paddingSymmetric(horizontal: 30),
      ),
    );
  }
}
