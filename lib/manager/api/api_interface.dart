/// pinpin - api_interface
/// Created by xhz on 2022/7/27

import 'package:dio/dio.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';
import 'package:pinpin/model/msg_response.dart';


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

  Future<String?> getUploadFileToken();

  Future<MsgResponse?> sendVerifyCode(
      String email,
      bool isResetPassword
      );

  Future<MsgResponse?> activateAccount();
}