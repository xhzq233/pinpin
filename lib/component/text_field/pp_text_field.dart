/// pinpin - pp_text_field
/// Created by xhz on 11/08/2022

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:util/util.dart';

const _kDuration = Duration(milliseconds: 200);

typedef CounterBuilder = Widget? Function(
  BuildContext context, {
  required int currentLength,
  required bool isFocused,
  required int? maxLength,
});

enum PPTextFieldStyle {
  outline,
  //  need more args void Function()? onPressVisible;  bool? isPasswordVisible;
  obscure,
  backgroundFilled,
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
    this.suffixIcon,
    this.textFieldStyle = PPTextFieldStyle.outline,
    this.padding = const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
    this.radius = 15,
    this.limitations = const [],
    this.textAlign = TextAlign.start,
    this.counterBuilder = defaultCounterBuilder,
  });

  static Widget? defaultCounterBuilder(BuildContext context,
      {required int currentLength, required bool isFocused, required int? maxLength}) {
    return Text(
      '$currentLength/$maxLength',
      style: TextStyle(color: isFocused ? AppTheme.primary : AppTheme.gray80),
    );
  }

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
  final Widget? suffixIcon;
  final Validator? validator;
  final PPTextFieldStyle textFieldStyle;
  final EdgeInsets padding;
  final double radius;
  final List<TextFiledLimitation> limitations;
  final TextAlign textAlign;
  final CounterBuilder? counterBuilder;

  @override
  State<PPTextField> createState() => _PPTextFieldState();
}

class _PPTextFieldState extends State<PPTextField> {
  bool obscure = true;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  final RxString rxErrorText = RxString('');

  late final Rx<BoxDecoration> rxMFBoxDecoration =
      Rx(BoxDecoration(color: AppTheme.gray95, borderRadius: borderRadius));

  get borderRadius => BorderRadius.all(Radius.circular(widget.radius));

  @override
  void initState() {
    if (null != widget.controller) {
      textEditingController = widget.controller!;
    } else {
      textEditingController = TextEditingController();
    }
    lastTextContent = textEditingController.text;

    if (null != widget.focusNode) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    focusNode.addListener(focusNodeListener);
    super.initState();
  }

  void focusNodeListener() {
    if (widget.textFieldStyle == PPTextFieldStyle.backgroundFilled) {
      if (focusNode.hasFocus) {
        //如果开始聚焦
        rxMFBoxDecoration.value = BoxDecoration(
          color: AppTheme.gray100,
          borderRadius: borderRadius,
          border: const Border.symmetric(
            horizontal: BorderSide(color: AppTheme.primary, width: 2),
            vertical: BorderSide(color: AppTheme.primary, width: 2),
          ),
        );
      } else {
        rxMFBoxDecoration.value = BoxDecoration(color: AppTheme.gray95, borderRadius: borderRadius);
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
      lastTextContent = textEditingController.text;
    }
    if (null != widget.focusNode && oldWidget.focusNode != widget.focusNode) {
      focusNode.dispose();
      focusNode = widget.focusNode!;
      focusNode.addListener(focusNodeListener);
    }

    super.didUpdateWidget(oldWidget);
  }

  late String lastTextContent;

  void onTextChange(String str) {
    for (var func in widget.limitations) {
      if (!func.call(str)) {
        // Do not meet condition
        // Return to the original condition (Reset)
        final newValue = textEditingController.value.copyWith(
          text: lastTextContent,
          selection: TextSelection.collapsed(offset: lastTextContent.length),
        );
        if (!newValue.composing.isValid || newValue.isComposingRangeValid) {
          textEditingController.value = newValue;
        } else {
          textEditingController.text = lastTextContent;
        }
        return;
      }
    }

    // remove error hint when input rightly
    final validator = widget.validator;
    if (null != validator) {
      final errorText = validator.call(str);
      if (errorText == null) {
        rxErrorText.value = '';
      }
    }

    widget.onChanged?.call(str);
    lastTextContent = str;
  }

  Widget _obscureSuffix() => Icon(
        obscure ? Icons.visibility : Icons.visibility_off,
        size: 24,
      ).onTap(() {
        setState(() {
          obscure = !obscure;
        });
      });

  Widget? _outlineSuffix() {
    final Widget w;
    if (null != widget.suffixIcon) {
      w = widget.suffixIcon!;
    } else if (null != widget.suffixText) {
      w = _suffixText();
    } else {
      w = const SizedBox();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: double.infinity, maxWidth: 96),
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: w,
      ),
    );
  }

  Widget _suffixText() => FittedBox(
        child: Text(
          widget.suffixText!,
          style: AppTheme.headline7,
        ),
      );

  Widget buildTf() {
    if (widget.textFieldStyle == PPTextFieldStyle.backgroundFilled) {
      return Padding(
        padding: widget.padding,
        child: TextField(
          keyboardType: widget.keyboardType,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: onTextChange,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          style: widget.style,
          textAlign: widget.textAlign,
          decoration: InputDecoration.collapsed(
            hintText: widget.hintText,
            hintStyle: AppTheme.headline7.copyWith(color: AppTheme.gray80),
          ),
          buildCounter: widget.counterBuilder,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        ),
      ).background(GestureDetector(
        onTap: focusNode.requestFocus,
        child: Obx(
          () => AnimatedContainer(
            duration: _kDuration,
            decoration: rxMFBoxDecoration.value,
          ),
        ),
      ));
    } else {
      final Widget tf;

      final InputDecoration decoration = InputDecoration(
        contentPadding: widget.padding,
        hintText: widget.hintText,
        hintStyle: AppTheme.headline7.copyWith(color: AppTheme.gray80),
        border: OutlineInputBorder(borderRadius: borderRadius),
      );

      if (widget.textFieldStyle == PPTextFieldStyle.outline) {
        tf = TextField(
          keyboardType: widget.keyboardType,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: onTextChange,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          maxLines: 1,
          style: widget.style,
          decoration: decoration.copyWith(suffixIcon: _outlineSuffix()),
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        );
      } else {
        tf = TextField(
          keyboardType: widget.keyboardType,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: onTextChange,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          maxLines: 1,
          style: widget.style,
          decoration: decoration.copyWith(suffixIcon: _obscureSuffix()),
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          obscureText: obscure,
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
          Obx(
            () => Visibility(
              visible: rxErrorText.isNotEmpty,
              child: Text(
                rxErrorText.value,
                style: AppTheme.headline9.copyWith(color: AppTheme.secondary1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
