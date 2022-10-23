/// pinpin - home_pp_card
/// Created by xhz on 06/08/2022

import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
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
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
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
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
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
          padding: const EdgeInsets.only(top: 0.2, bottom: 1.8, left: 5, right: 5),
          child: Text(
            '${pp.nowNum}/${pp.demandingNum}',
            style: AppTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    final label = ClipPath(
      clipper: const CapsuleClipper(),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppTheme.primary2),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.7, bottom: 1.3, left: 5, right: 5),
          child: Text(
            'Label: ${pp.label}',
            style: AppTheme.headline8,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    final content = Text(
      pp.title,
      style: AppTheme.headline7,
      maxLines: 4,
      textAlign: TextAlign.start,
    );

    final timeline = Text(
      "${pp.deadline.year}-${pp.deadline.month}-${pp.deadline.day} ${pp.deadline.hour}:${pp.deadline.minute}:${pp.deadline.second}",
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
                  builder: (ctx) => PPImageButton(
                    onPressed: () {
                      pp.isFollowed = !pp.isFollowed;
                      (ctx as Element).markNeedsBuild();
                    },
                    active: pp.isFollowed ? AppAssets.star_active : AppAssets.star,
                  ),
                )
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
