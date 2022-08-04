/// pinpin - system_blur_effect
/// Created by xhz on 2022/8/3
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

extension CupertinoSystemBlurEffect on Widget {
  static const myWhite = Color(0xC3FFFFFF);

  Widget cupertinoSystemBlurEffect({Color color = myWhite}) => ClipRect(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: this,
      ).background(DecoratedBox(decoration: BoxDecoration(color: color))));
}
