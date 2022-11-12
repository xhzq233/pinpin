import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import 'controller.dart';

class EditPersonalProfilePage extends StatelessWidget {

  EditPersonalProfilePage({Key? key}) : super(key: key);

  final controller = Get.find<EditPersonalProfileController>();
  
  @override
  Widget build(BuildContext context) {

    const personSignature = Text(
      "啊对对对",
      style: AppTheme.headline8,
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    final profile = DecoratedBox(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white, boxShadow: [AppTheme.shadow]),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.8,
          child: TextField(
            style: AppTheme.headline7,
            textAlign: TextAlign.left,
            maxLines: 5,
            controller: controller.etController,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
    );

    return Scaffold(
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        highlightColor: Colors.transparent,// 去除水波纹
        splashColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PPNavigationBar(title: "个人简介"),
            const Padding(padding: EdgeInsets.only(bottom: 20)),

            profile.sized(width: 354, height: 191),

            const Padding(padding: EdgeInsets.only(bottom: 260)),
            PPCommonTextButton(
              title: '确认修改',
              onPressed: () {
                Get.back();
              },
            ),
            const Spacer()
          ],
        )
      )
    );
  }
}
