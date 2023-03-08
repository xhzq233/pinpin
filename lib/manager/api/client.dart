/// pinpin - http_client
/// Created by xhz on 27/07/2022
import 'package:dio/dio.dart';
import 'package:pinpin/manager/api/api.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/manager/api/client_interface.dart';
import 'package:pinpin/model/account/account.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';
import 'package:pinpin/model/reply/reply.dart';
import 'package:pinpin/model/reply/reply_list_data.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:pinpin/model/notice/notice.dart';
import 'package:pinpin/model/response/msg_response.dart';

PPNetWorkInterface Function({
  required String deviceName,
  required Account? Function() accountGetter,
  required void Function(Account) accountUpdater,
  required Future<PinPin?> Function(dynamic) ppGetter,
  required Future<Notice?> Function(dynamic) noticeGetter,
  required Future<Reply?> Function(dynamic) replyGetter,
  required Future<UserInfo?> Function(dynamic) userInfoGetter,
}) initPPHttp = _PPNetworkImplement.init;

class _PPNetworkImplement extends HttpClientInterface with PPNetWorkInterface {
  _PPNetworkImplement.init({
    required super.deviceName,
    required super.accountGetter,
    required super.accountUpdater,
    required super.ppGetter,
    required super.noticeGetter,
    required super.replyGetter,
    required super.userInfoGetter,
  }) : super.init();

  /// welcome
  @override
  Future<PinPinListData?> getPinPinData({
    required int type,
    required int label, // tag
    required int startTime,
    CancelToken? cancelToken,
  }) =>
      request(
        Api.getPinPinData,
        PinPinListData.fromJson,
        cancelToken: cancelToken,
        queryParameters: {
          'Type': type,
          'Label': label,
          'Start': startTime,
        },
      );

  @override
  Future<PinPinListData?> searchPinPinData({
    required String title,
    required int label,
    required int startTime,
  }) =>
      request(Api.searchPinPinData, PinPinListData.fromJson, queryParameters: {
        'Title': title,
        'Label': label,
        'Start': startTime,
      });

  @override
  Future<PinPinListData?> getValidPinPInData({
    required int type,
    required int label,
    required int startTime,
  }) =>
      request(Api.getValidPinPInData, PinPinListData.fromJson, queryParameters: {
        'Type': type,
        'Label': label,
        'Start': startTime,
      });

  /// manage
  @override
  Future<MsgResponse?> sendVerifyCode({
    required String email,
    required bool isResetPassword,
  }) {
    var formData = FormData.fromMap({"Email": email, "IsResetPassword": isResetPassword});
    return requestForMsg(Api.sendVerifyCode, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> activateAccount({
    required String email,
    required String verifyCode,
  }) {
    var formData = FormData.fromMap({"Email": email, "VerifyCode": verifyCode});
    return requestForMsg(Api.activateAccount, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> createUser({
    required String email,
    required String username,
    required String password,
    required String img,
  }) {
    var formData = FormData.fromMap({
      "Email": email,
      "Username": username,
      "Password": password,
      "Image": img,
    });
    return requestForMsg(Api.createUser, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<Account?> signIn({
    required String email,
    required String password,
  }) async {
    var formData = FormData.fromMap({
      "Email": email,
      "Password": password,
    });
    final account = await request(Api.signIn, Account.fromJson, data: formData);
    if (null != account) {
      account.email = email;
      accountUpdater.call(account);
    }
    return account;
  }

  @override
  Future<UserInfo?> getUserInfo({
    required String email,
  }) =>
      request(
        Api.getUserInfo,
        UserInfo.fromJson,
        jsonReplacement: {
          'Email': email,
        },
        queryParameters: {
          "Email": email,
        },
      );

  /// change
  @override
  Future<MsgResponse?> changePassword({
    required String email,
    required String verifyCode,
    required String newPassword,
  }) {
    FormData formData = FormData.fromMap({"Email": email, "VerifyCode": verifyCode, "NewPassword": newPassword});
    return requestForUserInfo(Api.changePassword, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<UserInfo?> changeProfileVisibility({
    required String email,
    required String showPinPin,
  }) {
    FormData formData = FormData.fromMap({"Email": email, "ShowPinpin": showPinPin});
    return requestForUserInfo(Api.changeProfileVisibility, UserInfo.fromJson, data: formData);
  }

  @override
  Future<UserInfo?> changeUserAvatar({
    required String email,
    required String newImg,
  }) {
    FormData formData = FormData.fromMap({"Email": email, "Image": newImg});
    return requestForUserInfo(Api.changeUserAvatar, UserInfo.fromJson, data: formData);
  }

  @override
  Future<UserInfo?> changeUserBackground({
    required String email,
    required String background,
  }) {
    FormData formData = FormData.fromMap({"Email": email, "Background": background});
    return requestForUserInfo(Api.changeUserBackground, UserInfo.fromJson, data: formData);
  }

  @override
  Future<UserInfo?> changeUserDescription({
    required String email,
    required String masterIntroduction,
  }) {
    FormData formData = FormData.fromMap({"Email": email, "MasterIntroduction": masterIntroduction});
    return requestForUserInfo(Api.changeUserDescription, UserInfo.fromJson, data: formData);
  }

  @override
  Future<UserInfo?> changeUserTags({
    required String email,
    required String myTags,
  }) {
    FormData formData = FormData.fromMap({"Email": email, "MyTags": myTags});
    return requestForUserInfo(Api.changeUserTags, UserInfo.fromJson, data: formData);
  }

  @override
  Future<UserInfo?> changeUsername({
    required String email,
    required String username,
  }) {
    FormData formData = FormData.fromMap({"Email": email, "Username": username});
    return requestForUserInfo(Api.changeUsername, UserInfo.fromJson, data: formData);
  }

  @override
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
  }) {
    final formData = {
      "Title": title,
      "Label": label,
      "Type": type,
      "Deadline": deadline,
      "Description": description,
      "DemandingNum": demandingNum,
      "NowNum": nowNum,
      "DemandingDescription": demandingDescription,
      "TeamIntroduction": teamIntroduction
    };

    return requestForMsg(Api.createPinpin, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> createReply({
    required String content,
    required int pinPinId,
    int? replyTo, //后台默认为0
  }) {
    FormData formData = FormData.fromMap({"Content": content, "PinpinId": pinPinId, "ReplyTo": replyTo});

    return requestForMsg(Api.createReply, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> createReportPinPin({
    required int pinPinId,
    required String content,
  }) {
    FormData formData = FormData.fromMap({
      "Content": content,
      "PinpinId": pinPinId,
    });

    return requestForMsg(Api.createReportPinPin, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> createReportUser({
    required String email,
    required String content,
  }) {
    FormData formData = FormData.fromMap({
      "Content": content,
      "EmailReported": email,
    });

    return requestForMsg(Api.createReportPinPin, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> createSysNotice({
    required String title,
    required String content,
    required String email,
  }) {
    FormData formData = FormData.fromMap({"Content": content, "Email": email, "Title": title});

    return requestForMsg(Api.createSysNotice, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> createThumbUp({
    required int replyId,
  }) {
    FormData formData = FormData.fromMap({"ReplyId": replyId});
    return requestForMsg(Api.createThumbUp, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> deletePinpin({
    required int pinPinId,
  }) {
    FormData formData = FormData.fromMap({
      "PinpinId": pinPinId,
    });

    return requestForMsg(Api.deletePinpin, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> deleteReply({
    required int pinPinId,
    required int replyId,
  }) {
    FormData formData = FormData.fromMap({"PinpinId": pinPinId, "ReplyId": replyId});

    return requestForMsg(Api.deleteReply, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> followPinPin({
    required int pinPinId,
  }) {
    FormData formData = FormData.fromMap({
      "PinpinId": pinPinId,
    });

    return requestForMsg(Api.followPinPin, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<ReplyListData?> getAllReplys({
    required int pinPinId,
  }) =>
      requestForMsg(
        Api.getAllReplys,
        ReplyListData.fromJson,
        queryParameters: {
          "PinpinId": pinPinId,
        },
      );

  @override
  Future<List<PinPin>?> getMyFollow() => requestList(Api.getMyFollow, PinPin.fromJson);

  @override
  Future<List<PinPin>?> getMyPinPin() => requestList(Api.getMyFollow, PinPin.fromJson);

  @override
  Future<List<Notice>?> getMySysNotice() => requestList(Api.getMySysNotice, Notice.fromJson);

  @override
  Future<List<Notice>?> getNotice() => requestList(Api.getNotice, Notice.fromJson);

  @override
  Future<PinPin?> getSpecifiedPinpin({
    required int pinPinId,
  }) {
    FormData formData = FormData.fromMap({
      "PinpinId": pinPinId,
    });
    return request(Api.getSpecifiedPinpin, PinPin.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> readNotice({
    required int id,
  }) {
    FormData formData = FormData.fromMap({
      "NoticeId": id,
    });

    return requestForMsg(Api.readNotice, MsgResponse.fromJson, data: formData);
  }

  @override
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
  }) {
    FormData formData = FormData.fromMap({
      "PinpinId": pinPinId,
      "Title": title,
      "Label": label,
      "Type": type,
      "Deadline": deadline,
      "Description": description,
      "DemandingNum": demandingNum,
      "NowNum": nowNum,
      "DemandingDescription": demandingDescription,
      "TeamIntroduction": teamIntroduction
    });

    return requestForMsg(Api.updatePinpin, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> updatePinpinPersonQty({
    required int pinPinId,
    required int demandingNum,
    required int nowNum,
  }) {
    FormData formData = FormData.fromMap({
      "PinpinId": pinPinId,
      "DemandingNum": demandingNum,
      "NowNum": nowNum,
    });

    return requestForMsg(Api.updatePinpinPersonQty, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> addPinpinPersonQty({
    required int pinPinId,
  }) {
    FormData formData = FormData.fromMap({
      "PinpinId": pinPinId,
    });

    return requestForMsg(Api.addPinpinPersonQty, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> cancelThumpUp({
    required int replyId,
  }) {
    FormData formData = FormData.fromMap({
      "ReplyId": replyId,
    });
    return requestForMsg(Api.cancelThumpUp, MsgResponse.fromJson, data: formData);
  }

  @override
  Future<MsgResponse?> create({
    required String content,
  }) {
    FormData formData = FormData.fromMap({
      "Content": content,
    });
    return requestForMsg(Api.create, MsgResponse.fromJson, data: formData);
  }
}
