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

class PasswordSetPage extends StatelessWidget {
  const PasswordSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PasswordSetLogic>();
    return BaseLoginPage(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                "设置密码",
                style: AppTheme.headline2,
              ),
            ),
          ),
          PPTextField(
            hintText: '输入密码',
            textFieldStyle: PPTextFieldStyle.obscure,
          ),
          const PPCommonTextButton(
            title: '加入',
          ),
          const Flexible(
            child: SizedBox(
              height: 500,
            ),
          ),
        ],
      ),
    );
  }
}
