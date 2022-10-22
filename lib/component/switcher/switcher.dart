/// pinpin - switcher
/// Created by xhz on 11/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

class PPSwitcher extends StatelessWidget {
  const PPSwitcher(
      {Key? key,
      required this.rxIndex,
      required this.titles,
      this.onTap = defaultOnTap,
      this.height,
      this.width,
      this.fontScale = 0.4})
      : super(key: key);
  final RxInt rxIndex;
  final List<String> titles;
  final void Function(int, RxInt) onTap;
  final double? width;
  final double? height;
  final double fontScale;

  static defaultOnTap(int nowTapping, RxInt state) {
    state.value = nowTapping;
  }

  static const _animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)), color: AppTheme.gray95, boxShadow: [AppTheme.shadow]),
      height: height,
      width: width,
      child: Obx(
        () => Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(-1.0 + 2 * rxIndex.value / (titles.length - 1), 0),
              duration: _animationDuration,
              child: FractionallySizedBox(
                widthFactor: 1 / titles.length,
                heightFactor: 1,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [AppTheme.shadow],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (int i = 0; i < titles.length; i++)
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: fontScale,
                      heightFactor: 1,
                      child: FittedBox(
                        child: HoldActiveButton(
                          onPressed: () => onTap(i, rxIndex),
                          builder: (_) => Padding(
                            padding: const EdgeInsets.all(5.6),
                            child: AnimatedOpacity(
                              opacity: rxIndex.value == i ? 1.0 : 0.5,
                              duration: _animationDuration,
                              child: Text(titles[i]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
