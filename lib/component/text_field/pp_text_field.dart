/// pinpin - pp_text_field
/// Created by xhz on 11/08/2022

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

class PPTextField extends StatefulWidget {
  const PPTextField({
    super.key,
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
    this.hintText,
    this.suffixText,
    required this.textFieldStyle,
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? style;
  final String? hintText;
  final String? suffixText;
  final Validator? validator;
  final PPTextFieldStyle textFieldStyle;

  @override
  State<PPTextField> createState() => _PPTextFieldState();
}

class _PPTextFieldState extends State<PPTextField> {
  bool isPasswordVisible = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  final RxString rxErrorText = RxString('');

  final Rx<BoxDecoration> rxMFBoxDecoration =
      Rx(const BoxDecoration(color: AppTheme.gray95, borderRadius: BorderRadius.all(Radius.circular(15))));

  @override
  void initState() {
    if (null != widget.controller) {
      textEditingController = widget.controller!;
    } else {
      textEditingController = TextEditingController();
    }

    if (null != widget.focusNode) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    focusNode.addListener(focusNodeListener);
    super.initState();
  }

  void focusNodeListener() {
    if (widget.textFieldStyle == PPTextFieldStyle.multilineFilled) {
      if (focusNode.hasFocus) {
        //如果开始聚焦
        rxMFBoxDecoration.value = const BoxDecoration(
            color: AppTheme.gray100,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.symmetric(
                horizontal: BorderSide(color: AppTheme.primary, width: 2),
                vertical: BorderSide(color: AppTheme.primary, width: 2)));
      } else {
        rxMFBoxDecoration.value =
            const BoxDecoration(color: AppTheme.gray95, borderRadius: BorderRadius.all(Radius.circular(15)));
      }
    }

    final validator = widget.validator;
    if (null == validator) return;

    if (!focusNode.hasFocus) {
      //如果是退出聚焦
      final errorText = validator.call(textEditingController.text);
      if (errorText != null) {
        rxErrorText.value = errorText;
      } else {
        rxErrorText.value = '';
      }
    }
  }

  @override
  void didUpdateWidget(covariant PPTextField oldWidget) {
    if (null != widget.controller && oldWidget.controller != widget.controller) {
      textEditingController = widget.controller!;
    }
    if (null != widget.focusNode && oldWidget.focusNode != widget.focusNode) {
      focusNode.dispose();
      focusNode = widget.focusNode!;
      focusNode.addListener(focusNodeListener);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  static Widget? counterBuilder(BuildContext context,
      {required int currentLength, required bool isFocused, required int? maxLength}) {
    return Text(
      '$currentLength/$maxLength',
      style: TextStyle(color: isFocused ? AppTheme.primary : AppTheme.gray80),
    );
  }

  Widget _obscureSuffix() => Icon(
        isPasswordVisible ? Icons.visibility_off : Icons.visibility,
        size: 24,
      ).onTap(() {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      });

  Widget _suffixText() => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: double.infinity, maxWidth: 96),
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FittedBox(
            child: Text(
              widget.suffixText!,
              style: AppTheme.headline7,
            ),
          ),
        ),
      );

  Widget buildTf() {
    // const constraints = BoxConstraints(maxWidth: 330, maxHeight: 56);
    const padding = EdgeInsets.symmetric(vertical: 17, horizontal: 12);
    const duration = Duration(milliseconds: 200);

    if (widget.textFieldStyle == PPTextFieldStyle.multilineFilled) {
      return Padding(
        padding: padding,
        child: TextField(
          keyboardType: widget.keyboardType,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          style: widget.style,
          decoration: InputDecoration.collapsed(
            hintText: widget.hintText,
          ),
          buildCounter: widget.maxLength == null ? null : counterBuilder,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        ),
      ).background(Obx(() => AnimatedContainer(
            duration: duration,
            decoration: rxMFBoxDecoration.value,
          )));
    } else {
      final Widget tf;

      final InputDecoration decoration = InputDecoration(
          contentPadding: padding,
          hintText: widget.hintText,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))));

      if (widget.textFieldStyle == PPTextFieldStyle.outline) {
        tf = TextField(
          keyboardType: widget.keyboardType,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          maxLines: 1,
          style: widget.style,
          decoration: decoration.copyWith(suffixIcon: widget.suffixText == null ? null : _suffixText()),
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        );
      } else {
        tf = TextField(
          keyboardType: widget.keyboardType,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          maxLines: 1,
          style: widget.style,
          decoration: decoration.copyWith(suffixIcon: _obscureSuffix()),
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          obscureText: isPasswordVisible,
        );
      }
      return Center(child: tf);
    }
  }

  @override
  Widget build(BuildContext context) {
    final validator = widget.validator;
    final tf = buildTf();
    if (validator == null) {
      return tf;
    }
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tf,
          Obx(() => Visibility(
                visible: rxErrorText.isNotEmpty,
                child: Text(
                  rxErrorText.value,
                  style: AppTheme.headline9.copyWith(color: AppTheme.secondary1),
                ),
              )),
        ],
      ),
    );
  }
}
