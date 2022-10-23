import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class InnerUserInfo {
  InnerUserInfo({
    required this.image,
    required this.username,
  });

  @JsonKey(name: 'Username')
  String username;
  @JsonKey(name: 'Image')
  String image;

  factory InnerUserInfo.fromJson(dynamic json) {
    return _$InnerUserInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InnerUserInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Account {
  Account({
    required this.token,
    required this.userInfo,
    required this.email,
  });

  @JsonKey(name: 'Token')
  String token;

  @JsonKey(defaultValue: '')
  String email;

  @JsonKey(name: 'UserSignIn')
  InnerUserInfo userInfo;

  factory Account.fromJson(dynamic json) {
    return _$AccountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
