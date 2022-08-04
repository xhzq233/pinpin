/// pinpin - search_bar
/// Created by xhz on 2022/8/4
import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
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
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 7,
          blurRadius: 10,
          offset: Offset(1, 4),
        )
      ],
    ))
        .overlay(const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Text('All'),
        ))
        .overlay(Align(
            alignment: const Alignment(0.9, 0.0),
            child: PPImageButton(
              active: AppAssets.search_onclick,
              inactive: AppAssets.search,
              onPressed: () {},
            )));
  }
}
