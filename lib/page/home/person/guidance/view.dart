import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:util/util.dart';
import 'controller.dart';


extension _Bg on Widget {
  Widget _bg() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: this,
    ).background(const DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.gray100,
        boxShadow: [AppTheme.shadow],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    )),
  );
}

class GuidancePage extends StatelessWidget {
  const GuidancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 页面布局逻辑
    final controller = Get.find<GuidanceController>();

    final back = Image.asset(
      AppAssets.arrow_right,
      height: 45,
      fit: BoxFit.fitHeight,
    );

    Widget getItem(String title, void Function() function) {
      return HoldActiveButton(
        onPressed: function,
        builder: (_) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTheme.headline5,
              ),
              back
            ],
          ).paddingSymmetric(vertical: 3);
        },
      );
    }

    final titles = ["如何成功使用拼拼"];

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PPNavigationBar(title: "标签页"),
          
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          
          getItem("如何成功使用拼拼", () {})._bg().marginSymmetric(horizontal: 16),

          const Padding(padding: EdgeInsets.only(bottom: 300)),

          PPCommonTextButton(
            title: '寻求更多解决方案！',
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
