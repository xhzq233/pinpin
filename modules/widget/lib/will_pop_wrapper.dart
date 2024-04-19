/// chat_box - will_pop_wrapper
/// Created by xhz on 2/27/23

import 'package:flutter/material.dart';
import 'package:util/util.dart';

class WillPopWrapper extends StatelessWidget {
  const WillPopWrapper({
    Key? key,
    required this.child,
    this.willPop,
  }) : super(key: key);
  final void Function()? willPop;
  final Widget child;
  static DateTime? _lastPopTime;

  Future<bool> _willPop() async {
    if (null == _lastPopTime || DateTime.now().difference(_lastPopTime!) > const Duration(seconds: 1)) {
      _lastPopTime = DateTime.now();
      toast('Return again to Exist');
      return false;
    } else {
      willPop?.call();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: child,
    );
  }
}

