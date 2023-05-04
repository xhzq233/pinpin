import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/sliver_header_delegate.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:get/get.dart';

class MessageCenterHomePage extends StatelessWidget {
  MessageCenterHomePage({Key? key}) : super(key: key);

  static final maxHeight = topContainerProtruding + backgroundMaxHeight;
  static final minHeight = PinPinHomeSliverHeaderDelegate.appBarMinHeight;
  static final backgroundMaxHeight =
      PinPinHomeSliverHeaderDelegate.backgroundMaxHeight;
  static const topContainerProtruding = 38.0;
  static const topContainerHeight = 88.0;
  static const topContainerWidth = 350.0;
  static const avatarSize = 24.0;
  static const topTagSize = 44.0;
  bool selected = false;

  @override
  Widget build(BuildContext context) {

    final headers = <Widget>[
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverHeaderDelegate(
          maxHeight: maxHeight,
          minHeight: minHeight,
          builder: _buildHeader,
        ),
      ),
    ];

    final columns = [
      const Center(
        child: Text(
          "米罗伍德密室逃脱！",
          style: AppTheme.headline1,
        ),
      ),
      const SizedBox(height: 10),
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "已拼",
              style: AppTheme.headline6,
            ),
            SizedBox(
              width: 10,
            ),
            DemandingBubble(
              content: '3/7',
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "人",
              style: AppTheme.headline6,
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(),
          for (int i = 0; i < 7; i++)
            SizedBox(
              width: 40,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Image.asset(
                  AppAssets.profile,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          Spacer(),
        ],
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.5, vertical: 10),
          child: _buildMessage(),
        ),
      )
    ];

    return NestedScrollView(
      headerSliverBuilder: (context, _) => headers,
      body: Container(
        color: const Color(0xffE5E5E5),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 93), //SizedBox insert this
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 15),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13.5, vertical: 16),
                        child: Column(
                            mainAxisSize: MainAxisSize.max, children: columns),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Column(
      children: [
        for (int i = 0; i < 5; i++)
          GestureDetector(
            onTap: () {
              Get.toNamed(RN.message_chat);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                width: double.infinity,
                // 2. 边角 + 内边距修饰
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppTheme.secondary5,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    // 3. 文本框内容Column
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "小红枣",
                              style: AppTheme.headline7,
                            ),
                            Spacer(),
                            Text('12:20', style: AppTheme.headline7)
                          ],
                        ),
                        // 4. 使用ConstrainedBox约束文字
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 40),
                          child:
                              const Text(("你好！我是xx，请问你们还缺？"), style: AppTheme.headline4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildHeader(
      BuildContext context, double shrinkOffset, bool innerBoxIsScrolled) {

    final back = PPImageButton(
      active: AppAssets.arrow_left_white,
      onPressed: () {
        Get.back();
      }
    );

    final List<BoxShadow> shadow = selected
        ? const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              color: Color.fromRGBO(174, 207, 255, 0.5),
            )
          ]
        : const [];

    final rows = [
      for (int i = 0; i < 3; i++)
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: topTagSize,
              height: topTagSize,
              decoration: BoxDecoration(
                boxShadow: shadow,
              ),
              child: Image.asset(
                AppAssets.notification_center_comment,
                fit: BoxFit.fill,
                width: 20,
                height: 19,
              ),
            ),
            Text("评论",
                style: AppTheme.headline7.copyWith(color: Colors.blueAccent))
          ],
        )
    ];

    return Container(
      color: Colors.blue,
      child: Stack(
        children: [
          Container(
            alignment: const Alignment(0, 2.2),
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: SizedBox(
                width: double.infinity,
                height: topContainerHeight,
                // 4. 边角 + 内边距修饰
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: rows,
                    ),
                  ),
                )),
          ),
          Align(
            alignment: const Alignment(-1.0, -0.2),
            child: back,
          ),
          Align(
            alignment: const Alignment(0, -0.2),
            child: Text(
              "消息中心",
              style:  AppTheme.headline1.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
