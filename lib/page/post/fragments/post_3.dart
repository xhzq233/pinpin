/// pinpin - view
/// Created by xhz on 2022/8/8
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/page/post/logic.dart';

class PPPost3Fragment extends StatelessWidget {
  const PPPost3Fragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PPPostLogic>();
    const padding = SizedBox(height: 8);
    final TextStyle textStyle = AppTheme.headline7.copyWith(color: AppTheme.gray80);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('队伍信息', style: AppTheme.headline6),
        padding,
        PPTextField(
          textFieldStyle: PPTextFieldStyle.backgroundFilled,
          maxLines: 10,
          hintText: '选填，简单介绍一下自己，拼拼成功率更高哦！',
          maxLength: 200,
          controller: logic.teamInfo,
        ),
        padding,
        const Text('模块选择', style: AppTheme.headline6),
        padding,
        SizedBox(
          height: 45,
          width: double.infinity,
          child: GestureDetector(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppTheme.gray95,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(logic.ddl?.toIso8601String() ?? 'Select Deadline', style: textStyle),
              ),
            ),
            onTap: () async {
              final now = DateTime.now();
              final select = await showDatePicker(
                context: context,
                initialDate: logic.ddl ?? now,
                firstDate: now,
                lastDate: now.add(const Duration(days: 60)),
              );
              logic.ddl = select;
              (context as Element).markNeedsBuild();
            },
          ),
        ),
        padding,
        const Text('到截止日期后，本拼拼贴将自动删除'),
      ],
    );
  }
}
