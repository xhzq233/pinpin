/// pinpin - pp_text_field
/// Created by xhz on 11/08/2022

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoUnFocusWrap extends StatelessWidget {
  const AutoUnFocusWrap({Key? key, required this.child}) : super(key: key);
  final Widget child;

  void _unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _unfocus,
        onVerticalDragStart: (_) => _unfocus(),
        child: Center(
          child: child,
        )); //这里使用expand布局
  }
}

class PPTextField extends StatelessWidget {
  const PPTextField(
      {Key? key,
      this.maxLines = 1,
      this.keyboardType,
      this.controller,
      this.focusNode,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.maxLength,
      this.style,
      this.buildCounter,
      this.autofillHints,
      this.obscureText = false,
      this.decoration})
      : super(key: key);
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? style;
  final Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})?
      buildCounter;
  final Iterable<String>? autofillHints;
  final InputDecoration? decoration;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      maxLength: maxLength,
      maxLines: maxLines,
      style: style,
      decoration: decoration,
      autofillHints: autofillHints,
      buildCounter: buildCounter,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      expands: true,
      obscureText: obscureText,
    );
  }
}
