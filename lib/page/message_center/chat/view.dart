import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/message/expanded_viewport.dart';
import 'package:pinpin/component/message/message_item.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/model/message_chat/message_chat.dart';
import 'package:pinpin/model/message_chat/popup_choices.dart';
import 'package:pinpin/page/message_center/chat/controller.dart';
import 'package:util/clipper.dart';

class MessageChatPage extends StatefulWidget {
  const MessageChatPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageChatPageState();
}

class _MessageChatPageState extends State<MessageChatPage>
    with WidgetsBindingObserver {
  late ChatPageController controller;

  @override
  void initState() {
    super.initState();
    controller = ChatPageController();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Message>> stream = Stream.fromIterable(controller.mListMessage);

    return Scaffold(
        appBar: PPNavigationBar(
          actions: _buildActionsWidget(),
          title: "求拼拼小妹",
        ),
        body: Stack(
          children: [
            Container(
              color: const Color(0xFFF3F3F3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTopBar(),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: StreamBuilder<List<Message>>(
                            stream: stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                controller.data = snapshot.data!;
                                if (controller.data.isNotEmpty) {
                                  return _buildMessage();
                                } else {
                                  return _buildEmptyMessage();
                                }
                              } else {
                                return _buildLoadingMessage();
                              }
                            }),
                      ),
                    ),
                    buildInput()
                  ]),
            )
          ],
        ));
  }

  List<Widget> _buildActionsWidget() {
    List<Widget> actions = [];
    actions.add(GestureDetector(
        onTap: _buildPopupMenu,
        child: Obx(() => Image.asset(
              controller.more.value,
              width: 24,
              height: 24,
            ))));
    return actions;
  }

  void _buildPopupMenu() {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromLTRB(
        overlay.size.width, 60.0, 0.0, overlay.size.height - 60.0);

    showMenu<PopupChoices>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      items: controller.choices.map((PopupChoices choice) {
        return PopupMenuItem<PopupChoices>(
            onTap: choice.id == 1
                ? controller.onCancelClick
                : controller.onDeleteClick,
            value: choice,
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    choice.id == 1
                        ? controller.cancel.value
                        : controller.delete.value,
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    choice.title,
                    style: AppTheme.headline4,
                  ),
                ],
              ),
            ));
      }).toList(),
    ).then((value) {
      if (value == null) {
        controller.onMoreClick();
      }
    });

    controller.onMoreClick();
  }

  SizedBox buildTopBar() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.5, vertical: 16),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "米罗伍德密室逃脱！",
                    style: AppTheme.headline3,
                  ),
                  Row(
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
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  void onSendMessage(String content, MessageType type) {
    if (content.trim().isNotEmpty) {
      controller.textEditingController.clear();
      Message message = Message(
          uuid: Random.secure().nextInt(9999).toString(),
          type: MessageType.text,
          isSend: Random.secure().nextInt(9999) % 2 == 0 ? true : false,
          msg: content);
      controller.mListMessage[0].add(message);
      setState(() {});

      if (controller.listScrollController.hasClients) {
        controller.listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.blue);
    }
  }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xffE8E8E8), width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 15,
          ),
          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                onSendMessage(
                    controller.textEditingController.text, MessageType.text);
              },
              style: const TextStyle(color: Color(0xff203152), fontSize: 15),
              controller: controller.textEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: '待输入',
                hintStyle: TextStyle(color: Color(0xffaeaeae)),
              ),
              focusNode: controller.focusNode,
              autofocus: true,
            ),
          ),

          // Button send message
          Material(
            color: Colors.white,
            child: Container(
                width: 68,
                height: 32,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: HoldActiveButton(
                  builder: (_) => ClipPath(
                    clipper: const CapsuleClipper(),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        child: Text(
                          "发送",
                          style:
                              AppTheme.headline6.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => onSendMessage(
                      controller.textEditingController.text, MessageType.text),
                )),
          ),
        ],
      ),
    );
  }

  Scrollable _buildLoadingMessage() {
    return Scrollable(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller.listScrollController,
      axisDirection: AxisDirection.up,
      viewportBuilder: (context, offset) {
        return ExpandedViewport(
          offset: offset,
          axisDirection: AxisDirection.up,
          slivers: <Widget>[
            SliverExpanded(),
            SliverToBoxAdapter(
                child: Container(
              margin: const EdgeInsets.only(top: 5),
              height: 50,
              child: const Center(
                child: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              ),
            )),
          ],
        );
      },
    );
  }

  Scrollable _buildEmptyMessage() {
    return Scrollable(
      physics: const BouncingScrollPhysics(),
      controller: controller.listScrollController,
      axisDirection: AxisDirection.up,
      viewportBuilder: (context, offset) {
        return ExpandedViewport(
          offset: offset,
          axisDirection: AxisDirection.up,
          slivers: <Widget>[
            SliverExpanded(),
            SliverToBoxAdapter(
                child: Container(
              color: Colors.amberAccent,
            )),
          ],
        );
      },
    );
  }

  Scrollable _buildMessage() {
    return Scrollable(
      physics: const BouncingScrollPhysics(),
      controller: controller.listScrollController,
      axisDirection: AxisDirection.up,
      viewportBuilder: (context, offset) {
        return ExpandedViewport(
          offset: offset,
          axisDirection: AxisDirection.up,
          slivers: <Widget>[
            SliverExpanded(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (c, i) {
                  ChatMessageItem mChatItem = ChatMessageItem(
                    mMessage: controller.data[i],
                  );
                  return mChatItem;
                },
                childCount: controller.data.length,
              ),
            ),
            SliverToBoxAdapter(
              child: controller.isShowLoading
                  ? Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 50,
                      child: const Center(
                        child: SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}
