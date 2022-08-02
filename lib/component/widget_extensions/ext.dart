/// pinpin - ext
/// Created by xhz on 02/08/2022

import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget onTap(void Function() function) => GestureDetector(
        onTap: function,
        child: this,
      );

  Widget centralized() => Center(
        child: this,
      );
}
