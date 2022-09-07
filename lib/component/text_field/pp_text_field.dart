/// pinpin - pp_text_field
/// Created by xhz on 11/08/2022

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/util/validator.dart';

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
        child: child);
  }
}

enum PPTextFieldStyle {
  outline,
  //  need more args void Function()? onPressVisible;  bool? isPasswordVisible;
  obscure,
  multilineFilled
}

class PPTextField extends StatelessWidget {
  PPTextField({
    Key? key,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
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
    this.onPressVisible,
    this.isPasswordVisible,
    required this.textFieldStyle,
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
  final Validator? validator;
  final PPTextFieldStyle textFieldStyle;

  final void Function()? onPressVisible;
  final bool? isPasswordVisible;

  static Widget? counterBuilder(BuildContext context,
      {required int currentLength, required bool isFocused, required int? maxLength}) {
    return Text(
      '$currentLength/$maxLength',
      style: TextStyle(color: isFocused ? Colors.blue : Colors.grey),
    );
  }

  Widget _suffix() => Icon(
        isPasswordVisible! ? Icons.visibility_off : Icons.visibility,
        size: 24,
      ).onTap(onPressVisible!);

  Widget _suffixText() => ConstrainedBox(
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

  Widget buildTf() {
    if (textFieldStyle == PPTextFieldStyle.multilineFilled) {
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
    } else {
      final Widget tf;
      if (textFieldStyle == PPTextFieldStyle.outline) {
        tf = TextField(
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
              suffixIcon: suffixText == null ? null : _suffixText()),
          autofillHints: autofillHints,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        );
      } else {
        tf = TextField(
          keyboardType: keyboardType,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          maxLines: 1,
          style: style,
          decoration: InputDecoration(
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              hintText: hintText,
              suffixIcon: _suffix()),
          autofillHints: autofillHints,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          obscureText: isPasswordVisible!,
        );
      }
      return Center(
        child: SizedBox(
          width: 330,
          // height: 56,
          child: tf,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tf = buildTf();
    if (validator == null) {
      return tf;
    }
    final errorText = validator!.call(controller?.text ?? "");
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tf,
          Visibility(
            visible: errorText != null,
            child: Text(
              errorText ?? "",
              style: AppTheme.headline9.copyWith(color: AppTheme.secondary1),
            ),
          )
        ],
      ),
    );
  }
}
