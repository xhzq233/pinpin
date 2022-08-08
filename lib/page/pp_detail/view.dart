/// pinpin - view
/// Created by xhz on 2022/8/8
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

class PPDetailPage extends StatelessWidget {
  const PPDetailPage({Key? key, required this.pp}) : super(key: key);
  final PinPin pp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'pp_${pp.pinpinId}',
          child: PPHomeCardView(pp: pp),
        ).paddingSymmetric(horizontal: 19),
      ),
    );
  }
}
