/// pinpin - stateful_button
/// Created by xhz on 31/07/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/util/logger.dart';

typedef StateButtonOnPress<T> = void Function(Rx<T> rxState);
typedef StateButtonChildBuilder<T> = Widget Function(T state);

class StatefulButton<T> extends StatelessWidget {
  const StatefulButton({Key? key, required this.state, required this.childBuilder, required this.onPress})
      : super(key: key);
  final Rx<T> state;
  final StateButtonChildBuilder<T> childBuilder;
  final StateButtonOnPress<T> onPress;

  @override
  Widget build(BuildContext context) {
    Logger.i('$this build');
    return Obx(() => GestureDetector(
          onTap: () => onPress(state),
          child: childBuilder(state.value),
        ));
  }
}
