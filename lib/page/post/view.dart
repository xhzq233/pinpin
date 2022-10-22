import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:get/get.dart';
import 'package:pinpin/page/post/fragments/post_1.dart';
import 'package:pinpin/page/post/fragments/post_2.dart';
import 'package:pinpin/page/post/fragments/post_3.dart';
import 'package:pinpin/page/post/fragments/post_progress.dart';
import 'package:pinpin/page/post/logic.dart';

const _kPadding = 18.0;
const _kStatusHeightFactor = 67 / 742;
const _kBodyHeightFactor = 502 / 742;

class PPPostPage extends StatelessWidget {
  const PPPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PPPostLogic>();
    const children = [
      PPPost1Fragment(),
      PPPost2Fragment(),
      PPPost3Fragment(),
    ];
    const bg = BoxDecoration(color: AppTheme.gray100, borderRadius: BorderRadius.all(Radius.circular(20)));

    return Scaffold(
      appBar: const PPNavigationBar(
        title: '发布拼拼',
      ),
      body: LayoutBuilder(
        builder: (_, layout) {
          final height = layout.maxHeight;
          final width = layout.maxWidth;

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * _kStatusHeightFactor,
                width: width - _kPadding * 2,
                child: const DecoratedBox(decoration: bg, child: PPPostProgress()),
              ),
              SizedBox(
                height: height * _kBodyHeightFactor,
                width: width,
                child: PageView.builder(
                  controller: controller.pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: children.length,
                  itemBuilder: (_, int index) => Center(
                    child: SizedBox(
                      height: height * 502 / 742,
                      width: width - _kPadding * 2,
                      child: DecoratedBox(
                        decoration: bg,
                        child: children[index],
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => PPCommonTextButton(title: '发布', onPressed: controller.next.value)),
            ],
          );
        },
      ),
    );
  }
}
