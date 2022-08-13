/// pinpin - api_interface
/// Created by xhz on 2022/7/27

import 'package:dio/dio.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';

import '../../model/response/common_response.dart';


mixin PPNetWorkInterface {
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

  Future<CommonResponse?> getUploadFileToken();

  /// manage
  Future<CommonResponse?> sendVerifyCode(
      String email,
      bool isResetPassword
      );

  Future<CommonResponse?> activateAccount();

  Future<CommonResponse?> createUser();

  Future<CommonResponse?> signIn();

  Future<CommonResponse?> getUserInfo();

  /// change
  Future<CommonResponse?> changePassword();
  Future<CommonResponse?> changeUsername();
  Future<CommonResponse?> changeUserAvatar();
  Future<CommonResponse?> changeUserDescription();
  Future<CommonResponse?> changeProfileVisibility();
  Future<CommonResponse?> changeUserTags();
  Future<CommonResponse?> changeUserBackground();

  /// recruit
  Future<CommonResponse?> createPinpin();
  Future<CommonResponse?> updatePinpin();
  Future<CommonResponse?> updatePinpinPersonQty();
  Future<CommonResponse?> addPinpinPersonQty();
  Future<CommonResponse?> deletePinpin();
  Future<CommonResponse?> getSpecifiedPinpin();

  /// follow
  Future<CommonResponse?> followPinPin();

  /// reply
  Future<CommonResponse?> createReply();
  Future<CommonResponse?> getAllReplys();
  Future<CommonResponse?> deleteReply();

  ///thumb up
  Future<CommonResponse?> createThumbUp();
  Future<CommonResponse?> cancelThumpUp();

  /// advice
  Future<CommonResponse?> createReportUser();
  Future<CommonResponse?> createReportPinPin();

  /// notice
  Future<CommonResponse?> getNotice();
  Future<CommonResponse?> readNotice();

  /// sys_notice
  Future<CommonResponse?> createSysNotice();
  Future<CommonResponse?> getMySysNotice();

  /// myself
  Future<CommonResponse?> getMyPinPin();
  Future<CommonResponse?> getMyFollow();
}