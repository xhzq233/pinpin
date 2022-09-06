/// pinpin - pp_text_field
/// Created by xhz on 11/08/2022

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

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
        // onVerticalDragStart: (_) => _unfocus(),
        child: Center(
          child: child,
        ));
  }
}

class PPTextField extends StatelessWidget {
  const PPTextField({
    Key? key,
    this.maxLines = 1,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.maxLength,
    this.style,
    this.autofillHints,
    this.hintText,
    this.suffixText,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? style;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final String? suffixText;

  static Widget? counterBuilder(BuildContext context,
      {required int currentLength, required bool isFocused, required int? maxLength}) {
    return Text(
      '$currentLength/$maxLength',
      style: TextStyle(color: isFocused ? Colors.blue : Colors.grey),
    );
  }

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
      decoration: InputDecoration(hintText: hintText, suffixText: suffixText),
      autofillHints: autofillHints,
      buildCounter: maxLength == null ? counterBuilder : null,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
    );
  }
}

class PPOutLineTextField extends StatelessWidget {
  const PPOutLineTextField({
    Key? key,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.style,
    this.autofillHints,
    this.hintText,
    this.suffixText,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final TextStyle? style;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final String? suffixText;

  Widget _suffix() => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: double.infinity, maxWidth: 96),
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FittedBox(
            child: Text(
              suffixText!,
              style: AppTheme.headline7,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      maxLines: 1,
      style: style,
      decoration: InputDecoration(
          fillColor: AppTheme.secondary1,
          focusColor: AppTheme.secondary1,
          hoverColor: AppTheme.secondary1,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          hintText: hintText,
          suffixIcon: suffixText == null ? null : _suffix()),
      autofillHints: autofillHints,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
    ).sized(width: 330, height: 56);
  }
}

class PPObscureTextField extends StatelessWidget {
  const PPObscureTextField({
    Key? key,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.style,
    this.autofillHints,
    this.hintText,
    required this.onPressVisible,
    required this.isPasswordVisible,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final void Function() onPressVisible;
  final TextStyle? style;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final bool isPasswordVisible;

  Widget _suffix() => IconButton(
      icon: isPasswordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
      onPressed: onPressVisible);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      maxLines: 1,
      style: style,
      decoration: InputDecoration(
          fillColor: AppTheme.secondary1,
          focusColor: AppTheme.secondary1,
          hoverColor: AppTheme.secondary1,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          hintText: hintText,
          suffixIcon: _suffix()),
      autofillHints: autofillHints,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      obscureText: isPasswordVisible,
    ).sized(width: 330, height: 56);
  }
}
