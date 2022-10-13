/// pinpin - count_down_widget
/// Created by xhz on 12/09/2022

import 'package:flutter/material.dart';

class CountDownWidget extends StatelessWidget {
  const CountDownWidget({Key? key, required this.onChanged, required this.max}) : super(key: key);

  final void Function(bool) onChanged;

  final int max;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 64,);
  }
}
