import 'package:json_annotation/json_annotation.dart';
import 'reply.dart';

part 'reply_list_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ReplyListData {

  @JsonKey(name: "data")
  List<Reply> data;

  ReplyListData({required this.data});

  factory ReplyListData.fromJson(dynamic json) {
    return _$ReplyListDataFromJson(json);
  }

  @override
  String toString() {
    return 'ReplyListData{data: $data}';
  } //decoder

  //encoder
  Map<String, dynamic> toJson() => _$ReplyListDataToJson(this);
}