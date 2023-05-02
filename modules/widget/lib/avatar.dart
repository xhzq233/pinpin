/// pinpin - avatar
/// Created by xhz on 3/5/23

import 'package:flutter/material.dart';
import 'button/hold.dart';

Widget imageErrorBuilder(BuildContext ctx, Object o, StackTrace? stackTrace) {
  return const Icon(Icons.person_outline_rounded);
}

const _defaultAvatar = AssetImage('assets/profile.png');

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.url,
    this.onPressed,
    this.margin = 1,
    this.cachedHeight = 60,
    this.cachedWidth = 60,
  }) : super(key: key);
  final String? url;
  final void Function()? onPressed;
  final double margin;
  final int cachedWidth;
  final int cachedHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(margin),
      child: HoldButton(
        onPressed: onPressed,
        child: FadeInImage(
          placeholder: ResizeImage(
            _defaultAvatar,
            width: cachedWidth,
            height: cachedHeight,
          ),
          //为null加载默认头像
          image: ResizeImage(
            (url == null ? _defaultAvatar : NetworkImage(url!)) as ImageProvider,
            width: cachedWidth,
            height: cachedHeight,
          ),
          imageErrorBuilder: imageErrorBuilder,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
