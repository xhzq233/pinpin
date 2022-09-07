import 'package:json_annotation/json_annotation.dart';

part 'msg_response.g.dart';

@JsonSerializable()
class MsgResponse {
  MsgResponse();

  late String msg;

  @override
  String toString() {
    return 'MsgResponse{msg: $msg}';
  }

  factory MsgResponse.fromJson(dynamic json) => _$MsgResponseFromJson(json);
  dynamic toJson() => _$MsgResponseToJson(this);
}
