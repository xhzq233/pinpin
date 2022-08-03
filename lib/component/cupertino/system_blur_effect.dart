/// pinpin - system_blur_effect
/// Created by xhz on 2022/8/3
import 'dart:ui';
import 'package:flutter/material.dart';

extension CupertinoSystemBlurEffect on Widget {
  Widget cupertinoSystemBlurEffect() => ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: this,
        )
      );
}
