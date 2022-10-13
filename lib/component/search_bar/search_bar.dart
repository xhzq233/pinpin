/// pinpin - search_bar
/// Created by xhz on 2022/8/4
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';

class PPHomeSearchBar extends StatelessWidget {
  const PPHomeSearchBar({Key? key, this.onClick = defaultOnClick}) : super(key: key);
  static const heroTag = 'home_search_bar';

  final void Function() onClick;

  static void defaultOnClick() {
    Get.toNamed(RN.search);
  }

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
          ),
          // child: TextField(decoration: InputDecoration.collapsed(hintText: 'hintText'),),
        ),
        Align(
          alignment: const Alignment(-0.9, 0.0),
          child: Text(
            'All',
            style: AppTheme.headline5.copyWith(inherit: false, color: AppTheme.gray50),
          ),
        ),
        Align(
          alignment: const Alignment(0.9, 0.0),
          child: FractionallySizedBox(
            heightFactor: 0.76,
            child: PPImageButton(
              active: AppAssets.search,
              size: null,
              padding: 3.2,
              onPressed: onClick,
            ),
          ),
        ),
      ],
    );
  }
}
