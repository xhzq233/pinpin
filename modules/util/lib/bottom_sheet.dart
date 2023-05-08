import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<dynamic> showPinPinBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  return await showCustomModalBottomSheet<dynamic>(
    context: context,
    expand: false,
    animationCurve: Curves.easeInOut,
    backgroundColor: const Color.fromRGBO(0x0A, 0x11, 0x1A, 0.7),
    builder: builder,
    containerWidget: (context, animation, child) => Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      ),
    ),
  );
}