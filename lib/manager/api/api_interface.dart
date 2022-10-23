/// pinpin - api_interface
/// Created by xhz on 2022/7/27

import 'package:dio/dio.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';
import 'package:pinpin/model/reply/reply_list_data.dart';
import 'package:pinpin/model/user_info/user_info.dart';

import '../../model/notice/notice.dart';
import '../../model/pinpin/history_pin_pin.dart';
import '../../model/pinpin/pin_pin.dart';
import '../../model/response/msg_response.dart';

mixin PPNetWorkInterface {
  /// welcome
  Future<PinPinListData?> getPinPinData({
    required int type,
    required int label, // tag
    required int startTime,
    CancelToken? cancelToken,
  });

  Future<PinPinListData?> searchPinPinData({
    required String title,
    required int label, // tag
    required int startTime,
  });

  Future<PinPinListData?> getValidPinPInData({
    required int type,
    required int label,
    required int startTime,
  });

  // Future<MsgResponse?> getUploadFileToken();

  /// manage
  Future<MsgResponse?> sendVerifyCode({
    required String email, //限制10位
    required bool isResetPassword,
  });

  Future<MsgResponse?> activateAccount({
    required String email,
    required String verifyCode, //限制不为空
  });

  Future<MsgResponse?> createUser({
    required String email,
    required String username,
    required String password,
    required String img, // url
  });

  Future<MsgResponse?> signIn({
    required String email,
    required String password,
  });

  Future<UserInfo?> getUserInfo({
    required String email,
  });

  /// change
  Future<MsgResponse?> changePassword({
    required String email,
    required String verifyCode,
    required String newPassword,
  });

  Future<UserInfo?> changeUsername({
    required String email,
    required String username,
  });

  Future<UserInfo?> changeUserAvatar({
    required String email,
    required String newImg,
  });

  Future<UserInfo?> changeUserDescription({
    required String email,
    required String masterIntroduction,
  });

  Future<UserInfo?> changeProfileVisibility({
    required String email,
    required String showPinPin, //默认为true
  });

  Future<UserInfo?> changeUserTags({
    required String email,
    required String myTags,
  });

  Future<UserInfo?> changeUserBackground({
    required String email,
    required String background,
  });

  /// recruit
  Future<MsgResponse?> createPinpin({
    required String title,
    required int label,
    required int type,
    required String deadline,
    String? description,
    required int demandingNum,
    required int nowNum,
    String? demandingDescription,
    String? teamIntroduction,
  });

  Future<MsgResponse?> updatePinpin({
    required int pinPinId,
    required String title,
    required int label,
    required int type,
    required String deadline,
    String? description,
    required int demandingNum,
    required int nowNum,
    String? demandingDescription,
    String? teamIntroduction,
  });

  Future<MsgResponse?> updatePinpinPersonQty({
    required int pinPinId,
    required int demandingNum,
    required int nowNum,
  });

  Future<MsgResponse?> addPinpinPersonQty({
    required int pinPinId,
  });

  Future<MsgResponse?> deletePinpin({
    required int pinPinId,
  });

  Future<HistoryPinPin?> getSpecifiedPinpin({
    required int pinPinId,
  });

  /// follow  一次关注，一次取消
  Future<MsgResponse?> followPinPin({required int pinPinId});

  /// reply
  Future<MsgResponse?> createReply({required String content, required int pinPinId, int? replyTo //后台默认为0
      });

  Future<ReplyListData?> getAllReplys({
    required int pinPinId,
  });

  Future<MsgResponse?> deleteReply({
    required int pinPinId,
    required int replyId,
  });

  ///thumb up
  Future<MsgResponse?> createThumbUp({
    required int replyId,
  });

  Future<MsgResponse?> cancelThumpUp({
    required int replyId,
  });

  /// advice
  Future<MsgResponse?> createReportUser({
    required String email,
    required String content,
  });

  Future<MsgResponse?> createReportPinPin({
    required int pinPinId,
    required String content,
  });

  Future<MsgResponse?> create({
    required String content,
  });

  /// notice
  Future<List<Notice>?> getNotice();

  Future<MsgResponse?> readNotice({
    required int id,
  });

  /// sys_notice
  Future<MsgResponse?> createSysNotice({
    required String title,
    required String content,
    required String email,
  });

  Future<List<Notice>?> getMySysNotice();

  /// myself
  Future<List<PinPin>?> getMyPinPin();

  Future<List<PinPin>?> getMyFollow();
}
