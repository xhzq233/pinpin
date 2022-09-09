/// pinpin - search_bar
/// Created by xhz on 2022/8/4
import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

class PPHomeSearchBar extends StatelessWidget {
  const PPHomeSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
            decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(25)),
      boxShadow: [AppTheme.shadow],
    ))
        .overlay(const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Text('All'),
        ))
        .overlay(Align(
            alignment: const Alignment(0.9, 0.0),
            child: PPImageButton(
              active: AppAssets.search_onclick,
              onPressed: () {},
            )));
  }
}
