/// pinpin - home_sliver_header 
/// Created by xhz on 2022/8/3
import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/i18n/i18n_names.dart';

class PinPinHomeSliverHeader extends StatelessWidget {
  const PinPinHomeSliverHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  BoxyDelegate;
    return SliverAppBar(
        floating: true,
        snap: true,
        pinned: true,
        expandedHeight: 120,
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            print(constraints.maxHeight);
            return FlexibleSpaceBar(
              title: Text(I18n.title.tr),
              background: Image.network(
                'https://xhzq.xyz/images/doge.png',
                fit: BoxFit.fitWidth,
              ),
            );
          },
        ));
  }
}
