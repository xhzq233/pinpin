class MsgResponse{
  String message;

  MsgResponse({
    required this.message,
  });


  @override
  String toString() {
    return 'MsgResponse{message: $message}';
  }

  factory MsgResponse.fromJson(dynamic json) => MsgResponse(
    message: json['msg'],
  );

  Map<String, dynamic> toJson() => {
    'msg': message,
  };


  @override
  int get hashCode =>
      message.hashCode;
}