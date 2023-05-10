/// pinpin - view
/// Created by xhz on 2022/8/8
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/bottom_sheet/bottom_sheet_header.dart';
import 'package:pinpin/component/constant.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:util/bottom_sheet.dart';
import 'package:widget/button/future_switch_button.dart';
import 'package:widget/widget.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/page/pp_detail/logic.dart';
import 'package:util/util.dart';

class PPDetailPage extends StatelessWidget {
  const PPDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PPDetailLogic>();
    final pp = logic.pp;
    final userInfo = logic.userInfo;
    const bottomLayer = FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.25,
      alignment: Alignment.topCenter,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
    );

    const buttonShadow = [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.04),
          offset: Offset(0, 3),
          blurRadius: 10)
    ];

    barButton(String asset, function) {
      return SizedBox(
        width: 35,
        height: 35,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              boxShadow: buttonShadow,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: HoldButton(
            onPressed: function,
            child: Image.asset(asset),
          ),
        ),
      );
    }

    const barButtonPadding = SizedBox(
      width: 12,
    );

    final actionButton = PPCommonTextButton(
      title: '求拼拼',
      style: PPCommonTextButtonStyle.outline,
      size: PPCommonTextButtonSize.tertiary,
      onPressed: () {},
    );

    final bottomBar = FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.1078,
      alignment: Alignment.bottomCenter,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppTheme.maskWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffEAEAEA),
              spreadRadius: 7,
              blurRadius: 25,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 12, left: 26),
              child: Align(
                alignment: Alignment.topCenter, //将其置顶进入safeArea
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center, //这里再变成center
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            boxShadow: buttonShadow,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: FutureSwitchButton<bool>(
                          initValue: pp.isFollowed,
                          pressedSwitch: (now) async {
                            final res = await logic.pressedFollow(pp.pinpinId);
                            return res ? !now : now;
                          },
                          builder: (now) {
                            return Image.asset(
                              now ? AppAssets.star_active : AppAssets.star,
                            );
                          },
                        ),
                      ),
                    ),
                    barButtonPadding,
                    barButton(AppAssets.share, () {}),
                    barButtonPadding,
                    barButton(AppAssets.comment, () {
                      showPinPinBottomSheet(
                          context: context,
                          builder: (context) => _buildComments(context),
                          enableDrag: false);
                    }),
                    const Spacer(),
                    actionButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final title = Text(
      pp.title,
      style: AppTheme.headline2,
    );
    final demanding = DemandingBubble(
      content: '${pp.nowNum}/${pp.demandingNum}',
    );
    Widget bookmark;

    if (pp.type == PinPin.ppt_study) {
      bookmark = const Text(
        '学习拼',
        style: TextStyle(
          inherit: false,
          color: Color(0xff3061BE),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (pp.type == PinPin.ppt_ett) {
      bookmark = const Text(
        '娱乐拼',
        style: TextStyle(
          inherit: false,
          color: Color(0xff3061BE),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      throw "PinPin.type Error";
    }

    const horizontalMargin = 16.5;
    const intrudingOnX = 4.42 + horizontalMargin;
    bookmark = Container(
      width: 60.6,
      height: 30,
      decoration: const BoxDecoration(
        color: AppTheme.secondary5,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x6196A3B7),
            offset: Offset(3, 3),
            blurRadius: 8,
          )
        ], //#96A3B761
      ),
      transform:
          Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, intrudingOnX, 0, 0, 1),
      child: Center(
        child: bookmark,
      ),
    );

    final firstLine = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        title,
        const Spacer(),
        demanding,
        const Spacer(
          flex: 8,
        ),
        bookmark,
      ],
    );

    final label = LabelBubble(
      content: AppAssets.labelMap[pp.type]![pp.label]?.title,
    );

    const borderSide = BorderSide(color: AppTheme.secondary5);

    final ddl = ClipPath(
      clipper: const CapsuleClipper(),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border:
              Border.symmetric(vertical: borderSide, horizontal: borderSide),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.9),
            child: Text(
              '截止时间 ${TimeConverter.fromDate(pp.deadline)}',
              style: AppTheme.headline11.copyWith(color: AppTheme.gray50),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );

    final secondLine = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 22,
          child: label,
        ),
        const SizedBox(
          width: 11,
        ),
        SizedBox(
          height: 22,
          child: ddl,
        ),
      ],
    );

    final avatar = Avatar(
      url: userInfo.image,
    );

    final nickname = Text(
      userInfo.username,
      style: AppTheme.headline7.copyWith(color: AppTheme.gray50),
    );

    final postTime = Text(
      '发布于${TimeConverter.fromSeconds(pp.createdAt)}',
      style: AppTheme.headline11.copyWith(color: AppTheme.gray80),
    );

    final avatarLine = SizedBox(
      height: 38,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: avatar,
          ),
          const SizedBox(width: 6),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    nickname,
                    const SizedBox(width: 8),
                    ConstantWidget.onlineWidget,
                  ],
                ),
              ),
              postTime,
            ],
          ),
          const Spacer(
            flex: 9,
          ),
        ],
      ),
    );

    /// MARK: content
    const contentPadding = EdgeInsets.symmetric(horizontal: 18, vertical: 17);

    const backgroundDec = BoxDecoration(
      color: AppTheme.secondary5,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ); //#F7FBFF

    const heading = ClipPath(
      clipper: CapsuleClipper(),
      child: SizedBox(
        width: 3.6,
        height: 15,
        child: ColoredBox(color: AppTheme.secondary3),
      ),
    );

    const TextStyle titleStyle = TextStyle(
      fontSize: 14,
      decoration: TextDecoration.none,
      color: AppTheme.gray30,
      fontWeight: FontWeight.w500,
      fontFamily: '.SF UI Display',
    );

    const TextStyle contentStyle = TextStyle(
      fontSize: 14,
      decoration: TextDecoration.none,
      color: AppTheme.gray50,
      fontWeight: FontWeight.w400,
      fontFamily: '.SF UI Display',
    );

    final List<Widget> columns = [];

    columns.addAll([
      firstLine,
      const SizedBox(
        height: 11.5,
      ),
      secondLine,
      const SizedBox(
        height: 21.4,
      ),
      avatarLine,
      const SizedBox(
        height: 25.3,
      ),
    ]);

    final Widget description;

    final fixedDescription = pp.description.isEmpty ? "暂无介绍。" : pp.description;

    description = SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: backgroundDec,
        child: Padding(
          padding: contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [heading, Text(' 活动概述', style: titleStyle)],
              ),
              const SizedBox(height: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 64),
                child: Text(fixedDescription, style: contentStyle),
              ),
            ],
          ),
        ),
      ),
    );

    final joiner = SizedBox(height: 24, width: 24, child: avatar);

    final joiners = Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Row(
        children: [joiner, joiner, joiner]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5),
                  child: e,
                ))
            .toList(),
      ),
    );

    final Widget demandingDescription;

    final fixedDemandingDescription =
        pp.demandingDescription.isEmpty ? "暂无介绍。" : pp.demandingDescription;

    demandingDescription = SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: backgroundDec,
        child: Padding(
          padding: contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [heading, Text(' 人员介绍', style: titleStyle)],
              ),
              const SizedBox(height: 6),
              Text(fixedDemandingDescription, style: contentStyle),
            ],
          ),
        ),
      ),
    );

    final Widget teamDesc;

    final fixedTeamDesc =
        pp.teamIntroduction.isEmpty ? "暂无介绍。" : pp.teamIntroduction;

    teamDesc = SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: backgroundDec,
        child: Padding(
          padding: contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [heading, Text(' 队伍信息', style: titleStyle)],
              ),
              const SizedBox(height: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 64),
                child: Text(fixedTeamDesc, style: contentStyle),
              ),
            ],
          ),
        ),
      ),
    );

    // add padding
    columns.addAll([
      description,
      const SizedBox(
        height: 18,
      ),
      joiners,
      const SizedBox(
        height: 18,
      ),
      demandingDescription,
      const SizedBox(
        height: 16,
      ),
      teamDesc,
    ]);

    final body = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const PPNavigationBar(
          title: '拼拼详情',
          whiteAccent: true,
        ),
        // const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalMargin, vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: columns,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );

    return Material(
      color: AppTheme.lightBackground,
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          bottomLayer,
          body,
          bottomBar,
        ],
      ),
    );
  }

  Widget _buildComments(BuildContext context) {
    final logic = Get.find<PPDetailLogic>();
    final pp = logic.pp;
    final userInfo = logic.userInfo;
    final avatar = Avatar(
      url: userInfo.image,
    );
    const buttonShadow = [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.04),
          offset: Offset(0, 3),
          blurRadius: 10)
    ];

    return SafeArea(
        child: SizedBox(
      height: 460,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, __) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const PPBottomSheetHeader(),
              )
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView(
                      reverse: false,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: List.generate(
                          100,
                          (index) => buildCommentItem(index, avatar,
                              buttonShadow, pp, logic, context)).toList()),
                ),
              ),
              SizedBox(
                  height: 20,
                  child: Container(
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildCommentItem(
      int index,
      Avatar avatar,
      List<BoxShadow>? buttonShadow,
      PinPin pp,
      PPDetailLogic logic,
      BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 94,
            child: Stack(
              children: [
                Positioned(
                    left: 20,
                    top: index == 0 ? 20 : 10,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: avatar,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: index == 0 ? 20 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("加分",
                          style: AppTheme.headline9
                              .copyWith(color: AppTheme.gray30)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("5-10 22:22",
                          style: AppTheme.headline11
                              .copyWith(color: AppTheme.gray80)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊",
                          style: AppTheme.headline8
                              .copyWith(color: AppTheme.gray20)),
                      const Spacer(),
                      buildStar(buttonShadow, pp, logic),
                      const SizedBox(
                        width: 32,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 2,
                        height: 26,
                        color: AppTheme.primary,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 6, right: 10),
                          child: Text(
                            "小蓝",
                            style: AppTheme.headline8
                                .copyWith(color: AppTheme.primary),
                          )),
                      Text("顶顶顶顶顶顶顶顶顶",
                          style: AppTheme.headline9
                              .copyWith(color: AppTheme.gray20)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 2,
                        height: 26,
                        color: AppTheme.primary,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 6, right: 10),
                          child: Text(
                            "小蓝",
                            style: AppTheme.headline8
                                .copyWith(color: AppTheme.primary),
                          )),
                      Text("顶顶顶顶顶顶顶顶顶",
                          style: AppTheme.headline9
                              .copyWith(color: AppTheme.gray20)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showPinPinBottomSheet(
                          context: context,
                          builder: (context) => _buildCommentDetail(context),
                          enableDrag: false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 4),
                      height: 20,
                      child: Text(
                        "查看全部7条回复>",
                        style:
                            AppTheme.headline8.copyWith(color: AppTheme.gray0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildStar(
      List<BoxShadow>? buttonShadow, PinPin pp, PPDetailLogic logic) {
    return SizedBox(
      width: 25,
      height: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
            boxShadow: buttonShadow,
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: FutureSwitchButton<bool>(
          initValue: pp.isFollowed,
          pressedSwitch: (now) async {
            final res = await logic.pressedFollow(pp.pinpinId);
            return res ? !now : now;
          },
          builder: (now) {
            return FittedBox(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  now ? AppAssets.thumbs_active : AppAssets.thumbs_inactive,
                  width: 20,
                  height: 20,
                ),
                now
                    ? Text(
                        "3",
                        style: AppTheme.headline11
                            .copyWith(color: AppTheme.primary),
                      )
                    : Text("2",
                        style: AppTheme.headline11
                            .copyWith(color: AppTheme.gray80))
              ],
            ));
          },
        ),
      ),
    );
  }

  Widget _buildCommentDetail(BuildContext context) {
    final logic = Get.find<PPDetailLogic>();
    final pp = logic.pp;
    final userInfo = logic.userInfo;
    final avatar = Avatar(
      url: userInfo.image,
    );
    const buttonShadow = [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.04),
          offset: Offset(0, 3),
          blurRadius: 10)
    ];

    return SafeArea(
        child: SizedBox(
      height: 460,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, __) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const PPBottomSheetHeader(),
              )
            ];
          },
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                  child: buildCommentItem(
                      0, avatar, buttonShadow, pp, logic, context)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("10条回复",
                        style:
                            AppTheme.headline4.copyWith(color: AppTheme.gray20)),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView(
                      reverse: false,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: List.generate(
                          100,
                          (index) => buildCommentItem(index, avatar,
                              buttonShadow, pp, logic, context)).toList()),
                ),
              ),
              SizedBox(
                  height: 20,
                  child: Container(
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}

class ModalInsideModal extends StatelessWidget {
  const ModalInsideModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      height: 460,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, __) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const PPBottomSheetHeader(),
              )
            ];
          },
          body: ListView(
              reverse: false,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: List.generate(
                  100,
                  (index) => Stack(
                        children: [],
                      )).toList()),
        ),
      ),
    ));
  }
}
