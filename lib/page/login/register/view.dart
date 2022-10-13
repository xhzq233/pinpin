import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/count_down/count_down_widget.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/page/login/login_base_page.dart';
import 'package:pinpin/page/login/register/logic.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterLogic>();
    return BaseLoginPage(
        body: Column(
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
          suffixText: '@hust.edu.cn',
          onChanged: controller.onTextChanged,
        ),
        PPTextField(
          hintText: '输入验证码',
          textFieldStyle: PPTextFieldStyle.outline,
          suffixIcon: CountDownWidget(max: 60, onChanged: (available) => {}),
          onChanged: controller.onTextChanged,
        ),
        Obx(
          () => PPCommonTextButton(
            title: '下一步',
            onPressed: controller.isBtnEnabled.value ? controller.next : null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "学号被占用？点击申诉",
              style: AppTheme.headline6.copyWith(color: Colors.blue),
            ).onTap(controller.appeal),
            Text(
              "已经注册？",
              style: AppTheme.headline6.copyWith(color: Colors.blue),
            ).onTap(controller.toLogin),
          ],
        ),
        Text(
          "1037拼拼会向您的华科校园邮箱发送邮件验证校园身份，您可稍后再进行验证。",
          style: AppTheme.headline9.copyWith(color: AppTheme.banned),
        ),
        const Flexible(
          child: SizedBox(
            height: 400,
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
        ).paddingOnly(bottom: 20),
      ],
    ));
  }
}
