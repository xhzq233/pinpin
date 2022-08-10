/// pinpin - home_pp_card
/// Created by xhz on 06/08/2022

import 'package:boxy/boxy.dart';
import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/util/clipper.dart';

class PPHomeCardView extends StatelessWidget {
  const PPHomeCardView({Key? key, required this.pp}) : super(key: key);
  final PinPin pp;
  static const onlineWidget = ClipPath(
    clipper: CapsuleClipper(),
    child: DecoratedBox(
      decoration: BoxDecoration(color: AppTheme.secondary5),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        child: Text(
          '在线',
          style: AppTheme.headline11,
          maxLines: 1,
        ),
      ),
    ),
  );

  static const offlineWidget = ClipPath(
    clipper: CapsuleClipper(),
    child: DecoratedBox(
      decoration: BoxDecoration(color: AppTheme.secondary5),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        child: Text(
          '在线',
          style: AppTheme.headline11,
          maxLines: 1,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final title = Text(
      pp.title,
      style: AppTheme.headline2,
      maxLines: 1,
    );
    final demandingQty = ClipPath(
      clipper: const CapsuleClipper(),
      child: DecoratedBox(
          decoration: const BoxDecoration(color: AppTheme.secondary3),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Text(
              '${pp.nowNum}/${pp.demandingNum}',
              style: AppTheme.headline6,
            ),
          )),
    );
    final label = ClipPath(
      clipper: CapsuleClipper(),
      child: DecoratedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          child: Text(
            '密室逃脱',
            style: AppTheme.headline8,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(color: AppTheme.primary2),
      ),
    );

    final content = Text(
      pp.title,
      style: AppTheme.headline7,
      maxLines: 4,
      textAlign: TextAlign.start,
    );
    final timeline = Text(
      pp.deadline.toIso8601String(),
      style: AppTheme.headline10,
      maxLines: 1,
    );

    final person = Text(
      pp.ownerEmail,
      style: AppTheme.headline11,
      maxLines: 1,
    );
    const horizontalSpacing = SizedBox(
      width: 10,
    );
    const verticalSpacing = SizedBox(
      height: 10,
    );

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [AppTheme.shadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title,
                Builder(
                    builder: (ctx) => Image.asset(
                          pp.isFollowed ? AppAssets.star_active : AppAssets.star,
                          height: 32,
                          fit: BoxFit.fitHeight,
                        ).onTap(() {
                          pp.isFollowed = !pp.isFollowed;
                          (ctx as Element).markNeedsBuild();
                        }))
              ],
            ),
            verticalSpacing,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [demandingQty, horizontalSpacing, label],
            ),
            verticalSpacing,
            content,
            verticalSpacing,
            Row(
              children: [person, horizontalSpacing, onlineWidget, const Spacer(), timeline],
            ),
          ],
        ),
      ),
    );
  }
}
