import 'package:flutter/material.dart';
import 'package:pinpin/component/bottom_sheet/pinpin_bottom_sheet.dart';

class BottomSheetFactory {
  static Future<int?> showBottomSheet(
      BuildContext context, List<String> options,
      {required void Function(dynamic) onFirstTap,
      required void Function(dynamic) onSecondTap}) async {
    return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent, // 背景颜色
      isScrollControlled: true, // 滚动控制
      context: context,
      builder: (BuildContext context) {
        return PPBottomSheet(
          context: context,
          options: options,
          onFirstTap: onFirstTap,
          onSecondTap: onSecondTap,
        );
      },
    );
  }
}
