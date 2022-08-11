import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import '../../../app/assets/name.dart';
import '../../../app/theme/app_theme.dart';
import '../../../component/stateful_button/pp_common_text_button.dart';
import 'logic.dart';

class VerifyPage extends GetView<VerifyLogic> {
  const VerifyPage({Key? key}) : super(key: key);

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
                const Text("输入验证码", style: AppTheme.headline2)
                    .centralized()
                    .paddingOnly(top: 20, bottom: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "验证邮件已经发送至",
                        style:
                        AppTheme.headline6.copyWith(color: AppTheme.banned),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 10),
                PPCommonTextButton(
                  title: '输入验证码',
                  onPressed: () {},
                  style: PPCommonTextButtonStyle.outline,
                ).paddingAll(10),
                const PPCommonTextButton(
                  title: '下一步',
                ).paddingAll(10),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
