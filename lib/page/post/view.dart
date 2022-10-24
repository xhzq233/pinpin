import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/page_view/page_view.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/text_field/unfocus.dart';
import 'package:pinpin/page/post/fragments/post_1.dart';
import 'package:pinpin/page/post/fragments/post_2.dart';
import 'package:pinpin/page/post/fragments/post_3.dart';
import 'package:pinpin/page/post/fragments/post_progress.dart';
import 'package:pinpin/page/post/logic.dart';

const _kPadding = 18.0;
const _kStatusHeightFactor = 67 / 742;
const _kBodyHeightFactor = 502 / 742;
const _padding = SizedBox(height: 30);

class PPPostPage extends StatelessWidget {
  const PPPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PPPostLogic>();
    const children = [
      PPPost1Fragment(),
      PPPost2Fragment(),
      PPPost3Fragment(),
    ];
    const bg = BoxDecoration(color: AppTheme.gray100, borderRadius: BorderRadius.all(Radius.circular(20)));

    return Scaffold(
      appBar: const PPNavigationBar(title: '发布拼拼'),
      body: AutoUnFocusWrap(
        child: LayoutBuilder(
          builder: (_, layout) {
            final maxHeight = layout.maxHeight;
            if (maxHeight > logic.maxHeight) {
              logic.maxHeight = maxHeight;
            }
            final height = max(logic.maxHeight, maxHeight);
            final width = layout.maxWidth;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _padding,
                SizedBox(
                  height: height * _kStatusHeightFactor,
                  width: width - _kPadding * 2,
                  child: const DecoratedBox(decoration: bg, child: PPPostProgress()),
                ),
                _padding,
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: height * _kBodyHeightFactor,
                        width: width,
                        child: CachePageView.builder(
                          cacheExtent: 2,
                          controller: logic.pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: children.length,
                          itemBuilder: (_, int index) => Align(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: width - _kPadding * 2,
                                minWidth: width - _kPadding * 2,
                                maxHeight: height * 502 / 742,
                              ),
                              child: DecoratedBox(
                                decoration: bg,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                  child: children[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _padding,
                      Obx(() => PPCommonTextButton(title: '发布', onPressed: logic.next.value)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
