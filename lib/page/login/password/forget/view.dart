import 'package:boxy/flex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../component/stateful_button/pp_common_text_button.dart';
import 'logic.dart';

class NewPasswordPage extends GetView<NewPasswordLogic> {
  const NewPasswordPage({Key? key}) : super(key: key);

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
                const Text("输入新密码", style: AppTheme.headline2)
                    .centralized()
                    .paddingOnly(top: 20, bottom: 40),
                PPCommonTextButton(
                  title: '输入密码',
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
