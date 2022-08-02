import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfo {
	@JsonKey(name: 'Background') 
	String background;
	@JsonKey(name: 'History') 
	List<PinPin> history;
	@JsonKey(name: 'Image') 
	String image;
	@JsonKey(name: 'MasterIntroduction') 
	String masterIntroduction;
	@JsonKey(name: 'MyTags') 
	List<String> myTags;
	@JsonKey(name: 'Username') 
	String username;
	String? token;
	int id = 0;

	UserInfo({
		required this.background,
		required this.history,
		required this.image,
		required this.masterIntroduction,
		required this.myTags,
		required this.username,
	});

	@override
	String toString() {
		return 'UserInfo(background: $background, history: $history, image: $image, masterIntroduction: $masterIntroduction, myTags: $myTags, username: $username)';
	}

	factory UserInfo.fromJson(Map<String, dynamic> json) {
		return _$UserInfoFromJson(json);
	}

	Map<String, dynamic> toJson() => _$UserInfoToJson(this);

	UserInfo copyWith({
		String? background,
		List<PinPin>? history,
		String? image,
		String? masterIntroduction,
		List<String>? myTags,
		String? username,
	}) {
		return UserInfo(
			background: background ?? this.background,
			history: history ?? this.history,
			image: image ?? this.image,
			masterIntroduction: masterIntroduction ?? this.masterIntroduction,
			myTags: myTags ?? this.myTags,
			username: username ?? this.username,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! UserInfo) return false;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			background.hashCode ^
			history.hashCode ^
			image.hashCode ^
			masterIntroduction.hashCode ^
			myTags.hashCode ^
			username.hashCode ;
}
