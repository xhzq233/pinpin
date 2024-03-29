import 'package:json_annotation/json_annotation.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:floor/floor.dart';

part 'user_info.g.dart';

@entity
@JsonSerializable(explicitToJson: true)
class UserInfo {
  @JsonKey(name: 'Background')
  final String background;
  @ignore
  @JsonKey(name: 'History')
  final List<PinPin>? history;
  @JsonKey(name: 'Image')
  final String image;
  @JsonKey(name: 'Brief')
  final String brief;
  @JsonKey(name: 'MyTags')
  final String myTags;
  @JsonKey(name: 'Username')
  final String username;

  @primaryKey
  @JsonKey(name: 'Email')
  final String email;

  static const sample = UserInfo(
    background: 'https://www.technocrazed.com/wp-content/uploads/2015/12/Windows-XP-wallpaper-23.jpg',
    history: [],
    image: 'https://q1.qlogo.cn/g?b=qq&nk=1761373255&s=640',
    brief: 'brief',
    myTags: 'myTags',
    username: '大家好啊',
    email: '1761373255@qq.com',
  );

  const UserInfo({
    required this.background,
    this.history,
    required this.image,
    required this.brief,
    required this.myTags,
    required this.username,
    required this.email,
  });

  factory UserInfo.fromJson(dynamic json) {
    return _$UserInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
