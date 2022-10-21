import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: BoxyColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "1037拼拼欢迎你",
                  style: AppTheme.headline1,
                )
                    .background(
                      Align(
                        alignment: const Alignment(-0.98, 0.9),
                        child: Container(
                          // padding: EdgeInsets.only(top: 20),
                          constraints: const BoxConstraints.tightFor(width: 127, height: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    )
                    .paddingOnly(left: 30, bottom: 7, top: 220),
                const Text(
                  "拼拼一下，就差你了！",
                  style: AppTheme.headline8,
                ).paddingOnly(left: 30),
              ],
            )),
        Align(
          alignment: const Alignment(-0.9, 0.80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PPCommonTextButton(
                title: '加入',
                onPressed: () {
                  Get.toNamed(RN.login);
                },
              ),
              const SizedBox(height: 20),
              PPCommonTextButton(
                title: '我先逛逛',
                style: PPCommonTextButtonStyle.outline,
                onPressed: () {
                  Get.toNamed(RN.home);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
