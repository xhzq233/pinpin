/// pinpin - search_bar
/// Created by xhz on 2022/8/4
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import '../../app/route/route_name.dart';

class PPHomeSearchBar extends StatelessWidget {
  const PPHomeSearchBar({Key? key}) : super(key: key);
  static const heroTag = 'home_search_bar';

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
            decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [AppTheme.shadow],
        )),
        const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Material(
            child: Text('All'),
          ),
        ),
        Align(
            alignment: const Alignment(0.9, 0.0),
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: PPImageButton(
                active: AppAssets.search,
                size: null,
                padding: 4,
                onPressed: () {
                  Get.toNamed(RN.search);
                },
              ),
            )),
      ],
    );
  }
}
