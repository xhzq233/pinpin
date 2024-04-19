/// pinpin - async_switch_button
/// Created by xhz on 3/11/23

import 'package:flutter/cupertino.dart';
import 'package:widget/widget.dart';
import 'package:get/get.dart';

typedef PressedSwitch<T> = Future<T> Function(T nowValue);
typedef SwitchedChildBuilder<T> = Widget Function(T nowValue);

class FutureSwitchButton<T> extends StatefulWidget {
  const FutureSwitchButton({
    Key? key,
    required this.initValue,
    required this.pressedSwitch,
    required this.builder,
  }) : super(key: key);
  final T initValue;
  final PressedSwitch<T> pressedSwitch;
  final SwitchedChildBuilder<T> builder;

  @override
  State<FutureSwitchButton<T>> createState() => _FutureSwitchButtonState<T>();
}

class _FutureSwitchButtonState<T> extends State<FutureSwitchButton<T>> {
  late final Rx<T> stateValue = Rx(widget.initValue);

  final Rx<bool> loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return HoldButton(
      child: Obx(() {
        if (loading.value) {
          return const FractionallySizedBox(
            widthFactor: 0.66,
            heightFactor: 0.66,
            child: FittedBox(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        return widget.builder.call(stateValue.value);
      }),
      onPressed: () async {
        loading.value = true;
        final res = await widget.pressedSwitch(stateValue.value);
        stateValue.value = res;
        loading.value = false;
      },
    );
  }
}
