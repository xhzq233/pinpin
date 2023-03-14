import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/message/pp_request.dart';
import 'package:pinpin/model/message_chat/message_chat.dart';

class ChatMessageItem extends StatefulWidget {
  Message? mMessage;

  ChatMessageItem({Key? key, this.mMessage}) : super(key: key);

  @override
  ChatMessageItemState createState() => ChatMessageItemState();
}

class ChatMessageItemState extends State<ChatMessageItem> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: widget.mMessage!.isSend!
          ? getSentMessageLayout()
          : getReceivedMessageLayout(),
    );
  }

  Widget getItemContent(Message mMessage) {
    switch (mMessage.type) {
      case MessageType.image:
        return Container();
      case MessageType.text:
        return Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          width: 200,
          decoration: BoxDecoration(color: const Color(0xffE8E8E8), borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(bottom: mMessage.isSend! ? 10 : 20, right: 10),
          child: Text(
            "${mMessage.msg}",
            style: const TextStyle(color: Color(0xff203152)),
          ),
        );
      case MessageType.request:
        return PPRequest();
        break;
      default:
        break;
    }
    return const Text("这里没有内容哦");
  }

  Widget getSentMessageLayout() {
    return Container(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              margin: const EdgeInsets.only(
                bottom: 5.0,
              ),
              child: getItemContent(widget.mMessage!)
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10.0, left: 5),
              child: CircleAvatar(
                backgroundImage: AssetImage(AppAssets.profile),
                radius: 16.0,
              ),
            ),
          ],
        ));
  }

  Widget getReceivedMessageLayout() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          //  mainAxisAlignment:MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(right: 10.0, left: 5),
              child: CircleAvatar(
                backgroundImage: AssetImage(AppAssets.profile),
                radius: 16.0,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              margin: const EdgeInsets.only(
                bottom: 5.0,
              ),
              child: getItemContent(widget.mMessage!)
            ),
          ],
        ));
  }
}
