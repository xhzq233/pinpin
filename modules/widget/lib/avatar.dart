/// pinpin - avatar
/// Created by xhz on 3/5/23

import 'package:flutter/material.dart';
import 'button/hold.dart';

Widget imageErrorBuilder(BuildContext ctx, Object o, StackTrace? stackTrace) {
  return Image.asset(
    'assets/profile.png', //出错加载默认头像
    fit: BoxFit.scaleDown,
  );
}

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.url, this.onPressed, this.margin = 1}) : super(key: key);
  final String? url;
  final void Function()? onPressed;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(margin),
      child: HoldButton(
        onPressed: onPressed,
        child: FadeInImage(
          placeholder: const AssetImage('assets/profile.png'), //为null加载默认头像
          image: (url == null ? const AssetImage('assets/profile.png') : NetworkImage(url!)) as ImageProvider,
          imageErrorBuilder: imageErrorBuilder,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
