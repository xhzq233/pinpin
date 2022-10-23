import 'package:json_annotation/json_annotation.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfo {
  @JsonKey(name: 'Background')
  String background;
  @JsonKey(name: 'History')
  List<PinPin>? history;
  @JsonKey(name: 'Image')
  String image;
  @JsonKey(name: 'Brief')
  String brief;
  @JsonKey(name: 'MyTags')
  String myTags;
  @JsonKey(name: 'Username')
  String username;

  UserInfo({
    required this.background,
    required this.history,
    required this.image,
    required this.brief,
    required this.myTags,
    required this.username,
  });

  factory UserInfo.fromJson(dynamic json) {
    return _$UserInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
