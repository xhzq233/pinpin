/// pinpin - view
/// Created by xhz on 2022/8/8
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/page/pp_detail/logic.dart';

class PPDetailPage extends StatelessWidget {
  const PPDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PPDetailLogic>();
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Hero(
          tag: 'pp_${logic.pp.pinpinId}',
          child: PPHomeCardView(pp: logic.pp),
        ),
        PPCommonTextButton(
          title: 'title',
          style: PPCommonTextButtonStyle.fill,
          onPressed: (){},
        )
      ]).paddingSymmetric(horizontal: 19),
    );
  }
}
