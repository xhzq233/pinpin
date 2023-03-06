/// pinpin - constant
/// Created by xhz on 3/5/23

import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:util/util.dart';

class ConstantWidget {
  const ConstantWidget._();

  static const onlineWidget = ClipPath(
    clipper: CapsuleClipper(),
    child: DecoratedBox(
      decoration: BoxDecoration(color: AppTheme.secondary5),
      child: Padding(
        padding: EdgeInsets.only(top: 2, bottom: 1, left: 6, right: 5),
        child: Text(
          '在线',
          style: TextStyle(
            fontSize: 11,
            decoration: TextDecoration.none,
            color: AppTheme.primary,
            fontWeight: FontWeight.w400,
            fontFamily: '.SF UI Display',
            height: 1.15,
          ),
          maxLines: 1,
        ),
      ),
    ),
  );

  static const offlineWidget = ClipPath(
    clipper: CapsuleClipper(),
    child: DecoratedBox(
      decoration: BoxDecoration(color: AppTheme.secondary5),
      child: Padding(
        padding: EdgeInsets.only(top: 2, bottom: 1, left: 6, right: 5),
        child: Text(
          '离线',
          style: TextStyle(
            fontSize: 11,
            decoration: TextDecoration.none,
            color: AppTheme.primary,
            fontWeight: FontWeight.w400,
            fontFamily: '.SF UI Display',
            height: 1.2,
          ),
          maxLines: 1,
        ),
      ),
    ),
  );
}
