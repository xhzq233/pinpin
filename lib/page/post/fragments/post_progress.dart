/// pinpin - view
/// Created by xhz on 2022/8/8
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/page/post/logic.dart';

const _kPageTransDuration = Duration(milliseconds: 400);
const _kProgressDuration = Duration(milliseconds: 220);

class PPPostProgress extends StatelessWidget {
  const PPPostProgress({Key? key}) : super(key: key);

  Widget _buildTitle(PPPostLogic logic, int index) {
    final Border? border;
    final Color color;
    final Color textColor;
    if (logic.progress.value >= index) {
      border = null;
      color = AppTheme.primary;
      textColor = AppTheme.gray100;
    } else {
      border = const Border.symmetric(
        vertical: BorderSide(width: 2, color: AppTheme.primary),
        horizontal: BorderSide(width: 2, color: AppTheme.primary),
      );
      color = AppTheme.gray100;
      textColor = AppTheme.primary;
    }

    return LayoutBuilder(builder: (_, layout) {
      final height = layout.maxHeight * 0.56;
      return SizedBox(
        height: height,
        width: height,
        child: DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, border: border, color: color),
          child: Center(
            child: Text('$index', style: AppTheme.headline10.copyWith(color: textColor)),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PPPostLogic>();

    // just using to click
    final List<Widget> clickRegions = [];
    for (int i = 0; i < 3; i++) {
      clickRegions.add(
        Expanded(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => logic.pageController.animateToPage(i, duration: _kPageTransDuration, curve: Curves.ease),
              child: const SizedBox.expand(
                child: ColoredBox(color: Colors.transparent), //must add color or cant be hit test
              ),
            ),
          ),
        ),
      );
    }

    final progresses = Obx(
      () => Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 2 / 3,
              // [spaceAround]: Place the free space evenly between the children as well as half of that
              // space before and after the first and last child. So (1 + 1)/(1 + 1 + 0.5 * 2)
              child: SizedBox(
                height: 3,
                width: double.infinity,
                child: ColoredBox(
                  color: AppTheme.gray80,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedFractionallySizedBox(
                      widthFactor: min(1.0, max(logic.progress.value / 3, 0)),
                      heightFactor: 1,
                      duration: _kProgressDuration,
                      child: const ColoredBox(color: AppTheme.primary),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTitle(logic, 1),
              _buildTitle(logic, 2),
              _buildTitle(logic, 3),
            ],
          ),
        ],
      ),
    );

    final titles = Obx(
      //will refresh multiple times so place it separately
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('基本信息',
              style: AppTheme.headline9
                  .copyWith(color: logic.currentPage.value == 0 ? AppTheme.primary : AppTheme.gray50)),
          Text('人员需求',
              style: AppTheme.headline9
                  .copyWith(color: logic.currentPage.value == 1 ? AppTheme.primary : AppTheme.gray50)),
          Text('详细信息',
              style: AppTheme.headline9
                  .copyWith(color: logic.currentPage.value == 2 ? AppTheme.primary : AppTheme.gray50)),
        ],
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(
              flex: 5,
              child: progresses,
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.topCenter,
                child: titles,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            clickRegions[0],
            const Spacer(flex: 2),
            clickRegions[1],
            const Spacer(flex: 2),
            clickRegions[2],
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
