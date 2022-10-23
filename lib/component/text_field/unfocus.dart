import 'package:flutter/material.dart';

class AutoUnFocusWrap extends StatelessWidget {
  const AutoUnFocusWrap({Key? key, required this.child}) : super(key: key);
  final Widget child;

  static void _unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _unfocus,
      // onVerticalDragStart: (_) => _unfocus(),
      child: child,
    );
  }
}
