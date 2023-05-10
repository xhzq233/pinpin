import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';

class PPBottomSheetHeader extends StatelessWidget {
  const PPBottomSheetHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _PPBottomSheetHeaderDelegate(),
      pinned: true,
    );
  }
}

class _PPBottomSheetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double preferredHeight = 30;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: preferredHeight,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Text(
            "共八条评论",
            style: AppTheme.headline3,
          ),
          const Spacer(),
          Image.asset(
            AppAssets.close,
            fit: BoxFit.contain,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  @override
  double get maxExtent => preferredHeight;

  @override
  double get minExtent => preferredHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
