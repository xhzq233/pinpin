/// pinpin - bottom_tab_bar
/// Created by xhz on 05/08/2022

import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

class PPBottomTabBar extends StatelessWidget {
  const PPBottomTabBar({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            color: AppTheme.maskWhite,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color(0xffEAEAEA),
                spreadRadius: 7,
                blurRadius: 25,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ).sized(height: 88, width: double.infinity),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ).blur(10),
      ],
    )
        .clipped(
          const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        )
        .sized(height: 88);
  }
}
