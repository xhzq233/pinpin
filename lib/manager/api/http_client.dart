/// pinpin - http_client
/// Created by xhz on 27/07/2022
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pinpin/manager/api/api.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/manager/api/http_client_interface.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';

import '../../model/response/common_response.dart';


class PPHttp extends HttpClientInterface with PPNetWorkInterface {

  PPHttp.init({required super.deviceName, required super.accountGetter, required super.accountUpdater}) : super.init();


  /// welcome **/
  @override
  Future<PinPinListData?> getPinPinData({
    required int type,
    required int label, // tag
    required int startTime,
    CancelToken? cancelToken,
  }) =>
      request(Api.getPinPinData, PinPinListData.fromJson, cancelToken: cancelToken, queryParameters: {
        'Type': type,
        'Label': label,
        'Start': startTime,
      });

  @override
  Future<PinPinListData?> searchPinPinData({
    required String title,
    required int label,
    required int startTime
  }) =>
      request(Api.searchPinPinData, PinPinListData.fromJson,queryParameters: {
        'Title': title,
        'Label': label,
        'Start': startTime,
      });

  @override
  Future<CommonResponse?> getUploadFileToken() {
    // TODO: implement getUploadFileToken
    throw UnimplementedError();
  }

  @override
  Future<PinPinListData?> getValidPinPInData({required int type, required int label, required int startTime}) {
    // TODO: implement getValidPinPInData
    throw UnimplementedError();
  }


  /// manage **/
  @override
  Future<CommonResponse?> sendVerifyCode(String email, bool isResetPassword) {
    var formData = {'Email': email, 'IsResetPassword': isResetPassword};
    var contentType= ContentType.parse("application/form-data") as String?;
    var options = Options(contentType: contentType);
    var req = request(Api.sendVerifyCode, CommonResponse.fromJson, data: formData,options: options);

    return req;
  }


  @override
  Future<CommonResponse?> activateAccount() {
    // TODO: implement activateAccount
    throw UnimplementedError();
  }



}

