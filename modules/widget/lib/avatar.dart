/// pinpin - avatar
/// Created by xhz on 3/5/23

import 'package:flutter/material.dart';
import 'button/hold.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.url, this.onPressed, this.margin = 1}) : super(key: key);
  final String url;
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
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/profile.png',
          image: url,
          imageErrorBuilder: (BuildContext ctx, Object o, StackTrace? stackTrace) {
            return Image.asset(
              'assets/profile.png',
              fit: BoxFit.scaleDown,
            );
          },
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
