import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/page/login/login_base_page.dart';

import 'logic.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerifyLogic>();
    return BaseLoginPage(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("输入验证码", style: AppTheme.headline2),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "验证邮件已经发送至",
                  style: AppTheme.headline6.copyWith(color: AppTheme.banned),
                ),
              ],
            ),
          ),
          const PPTextField(
            hintText: '输入验证码',
            textFieldStyle: PPTextFieldStyle.outline,
          ),
          const PPCommonTextButton(
            title: '下一步',
          ),
        ],
      ),
    ));
  }
}
