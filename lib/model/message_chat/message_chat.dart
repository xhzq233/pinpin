class Message {
  String?  uuid;
  bool?  isSend;
  UserInfo? from;
  UserInfo? target;
  int? createTime;
  MessageState? state;
  String? msg;
  MessageType type;

  Message({   this.uuid,  this.state,   this.isSend,   this.from,
      this.target,   this.createTime,   this.msg, this.type = MessageType.text});

}

enum MessageState {
  sending, // 正在发送中
  send_succeed, // 发送成功
  send_failed, // 发送失败
}

enum MessageType {
  text,
  image,
  request
}


class UserInfo {
  String? id;
  String? username;
  String? image;

  UserInfo({this.id, this.username, this.image});
}