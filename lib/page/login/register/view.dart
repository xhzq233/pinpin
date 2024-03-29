import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/count_down/count_down_widget.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:util/util.dart';
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
            padding: EdgeInsets.only(top: 16, bottom: 42),
            child: Center(
              child: Text(
                "注册1037拼拼",
                style: AppTheme.headline2,
              ),
            ),
          ),
          PPTextField(
            hintText: '输入学号',
            suffixText: '@hust.edu.cn',
            controller: controller.idTC,
            validator: Validators.studentID,
            onChanged: controller.onIDChanged,
          ),
          const SizedBox(
            height: 8,
          ),
          PPTextField(
            hintText: '输入验证码',
            suffixIcon: const FractionallySizedBox(
              widthFactor: 0.72,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.3),
                child: CountDownWidget(),
              ),
            ),
            validator: Validators.verifyCode,
            controller: controller.codeTC,
            onChanged: controller.onCodeChanged,
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => PPCommonTextButton(
              title: '下一步',
              onPressed: controller.btnEnabled.value ? controller.next : null,
            ),
          ),
          const SizedBox(
            height: 16,
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
          const SizedBox(
            height: 8,
          ),
          Text(
            "1037拼拼会向您的华科校园邮箱发送邮件验证校园身份，您可稍后再进行验证。",
            style: AppTheme.headline9.copyWith(color: AppTheme.banned),
          ),
          const Spacer(),
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
      ),
    );
  }
}
