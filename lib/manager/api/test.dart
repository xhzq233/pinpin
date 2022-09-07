import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../model/Constant.dart';
import '../../model/response/msg_response.dart';

class Test{
  Test();

  BuildContext? context;
  Options? _options;

  static Dio dio = Dio();

  Future<MsgResponse> postThumbUps({required int replyId}) async {

    ///发送 FormData:
    FormData formData = FormData.fromMap({"ReplyId": replyId});
    String url ="https://pinpin.pivotstudio.cn/api/manage/thumbUps/createThumbUp";
    ///发起 post 请求 如这里的注册用户信息
    dio.options.headers["Authorization"] = Constant.token;
    print(url);
    Response response = await dio
        .post(url, data: formData);
    return MsgResponse.fromJson(response.data);
  }

  Future<MsgResponse> deleteThumbUps({required int replyId}) async {

    String url ="https://pinpin.pivotstudio.cn/api/manage/thumbUps/deleteThumbUp";
    FormData formData = FormData.fromMap({"ReplyId": replyId});
    ///发起 post 请求 如这里的注册用户信息
    dio.options.headers["Authorization"] = Constant.token;
    print(url);
    Response response = await dio
        .delete(url, data: formData);
    return MsgResponse.fromJson(response.data);
  }
}

