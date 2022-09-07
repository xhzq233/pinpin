import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get/get.dart';
import 'package:pinpin/main.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/manager/api/api.dart';
import 'package:pinpin/manager/api/http_client.dart';
import 'package:pinpin/model/notice/notice.dart';
import 'package:pinpin/model/pinpin/history_pin_pin.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';
import 'package:pinpin/model/reply/reply_list_data.dart';
import 'package:pinpin/model/response/msg_response.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:pinpin/main.dart';

void main() {

  var http = PPHttp.init(accountGetter: () {  }, deviceName: '', accountUpdater: (UserInfo userInfo) {  });
  group("API", () {

    /// welcome
    test("getPinPinData",() async {
      PinPinListData? data;
      data = await http.getPinPinData(type: -1, label: -1, startTime: -1);
      print(data);
    });

    test("searchPinPinData", () async{
      PinPinListData? data;
      data = await http.searchPinPinData(title: "去", label: -1, startTime: -1);
      print(data);
    });

    test("getValidPinPInData", ()async{
      PinPinListData? data;
      data = await http.getValidPinPInData(type: -1, label: -1, startTime: -1);
      print(data);
    });

    /// manage
    test("sendVerifyCode", () async {
      MsgResponse? msg;
      msg = await http.sendVerifyCode(email: "U202013777", isResetPassword: true);
      print(msg);
    });
    test("activateAccount", () async {
      MsgResponse? msg;
      msg = await http.activateAccount(email: "U202013777", verifyCode: "993322"); //验证码需要正确，不正确400
      print(msg);
    });
    test("createUser", () async {
      MsgResponse? msg;
      msg = await http.createUser(email: "U202013777",username: "www",password: "5156",
      img: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fpic.baike.soso.com%2Fugc%2Fbaikepic2%2F4835%2F20220301104313-1985040554_png_860_1409_202178.jpg%2F0&imgrefurl=https%3A%2F%2Fbaike.sogou.com%2Fv30052.htm%3Fpid%3Dbaike.box&tbnid=39STO30sfJdMVM&vet=12ahUKEwi_04rR2p35AhWMgGMGHRfFBTUQMygBegUIARC0AQ..i&docid=GOTZqHXHXTbovM&w=860&h=1409&q=%E6%B4%BE%E5%A4%A7%E6%98%9F&ved=2ahUKEwi_04rR2p35AhWMgGMGHRfFBTUQMygBegUIARC0AQ");
      //参数为空出现400
      print(msg);
    });
    test("SignIn", () async {
      MsgResponse? msg;
      msg = await http.signIn(email: "U202013777",password: "whl20010825"); //密码参数错误出现500
      print(msg);
    });
    test("getUserInfo", () async {
      UserInfo? user;
      user = await http.getUserInfo(email: "U202013777");
      print(Api.getUserInfo.val);
      print(user);
    });

    /// change
    test("changePassword", () async {
      MsgResponse? msg;
      msg = await http.changePassword(email: "U202013777", verifyCode: "779984", newPassword: "whl20010825");
      print(msg);
    });
    test("change",() async{
      UserInfo? user;
      user = await http.changeUsername(email: "U202013777", username: "whl55556"); //？
      print(user);
    });


    /// recruit
    test("createPinPin", () async{
      MsgResponse? msg;
      msg = await http.createPinpin(
          title: "拼车",
          label: 1,
          type: 1,
          deadline: "2022-07-26T16:57:35.107Z",
          demandingNum: 100,
          nowNum: 10,
          description: "暂时没有"
      );
      print(msg);
    });
    test("updatePinPin", () async{
      MsgResponse? msg;
      msg = await http.updatePinpin(
          pinPinId: 4,
          title: "拼车",
          label: 1,
          type: 1,
          deadline: "2022-07-26T16:57:35.107Z",
          demandingNum: 100,
          nowNum: 12,
          description: "暂时没有"
      );
      print(msg);
    });
    test("updatePinpinPersonQty",()async{
      MsgResponse? msg;
      msg = await http.updatePinpinPersonQty(
          pinPinId: 4,
          demandingNum: 100,
          nowNum: 11,
      );
      print(msg);
    });
    // 400---暂时未解决
    test("addPinpinPersonQty", ()async{
      MsgResponse? msg;
      msg = await http.addPinpinPersonQty(
        pinPinId: 4,
      );
      print(msg);
    });
    test("deletePinpin", ()async{
      MsgResponse? msg;
      msg = await http.deletePinpin(
        pinPinId: 11,
      );
      print(msg);
    });
    // 400---json为空
    test("getDetailPinPin", ()async{
      HistoryPinPin? p;
      p = await http.getSpecifiedPinpin(pinPinId: 4);
      print(p);
    });


    /// follow
    test("follow", ()async{
      MsgResponse? msg;
      msg = await http.followPinPin(
        pinPinId: 11,
      );
      print(msg);
    });



    /// reply
    test("createReply", () async{
      MsgResponse? msg;
      msg = await http.createReply(content: "pinpin", pinPinId: 4
      );
      print(msg);
    });
    test("getAllReplys", () async{
      ReplyListData? list;
      list = await http.getAllReplys(pinPinId: 4);
      print(list);
    });
    test("deleteReply", () async{
      MsgResponse? msg;
      msg = await http.deleteReply(
          pinPinId: 4,
          replyId: 26, //id 错误出现400
      );
      print(msg);
    });


    /// thumbUps
    test("thumbUps2", () async{
      MsgResponse? msg;
      msg = await http.createThumbUp(replyId: 10);
      print(msg);
    });
    test("thumbUps4", () async{
      MsgResponse? msg;
      msg = await http.cancelThumpUp(replyId: 10);
      print(msg);
    });


    /// advice
    test("reportUser", () async{
      MsgResponse? msg;
      msg = await http.createReportUser(email: "U202013777", content: "测试举报");
      print(msg);
    });
    test("reportPinPin", () async{
      MsgResponse? msg;
      msg = await http.createReportPinPin(pinPinId: 4, content: "测试举报");
      print(msg);
    });
    test("create",()async{
      MsgResponse? msg;
      msg = await http.create(content: "测试举报");
      print(msg);
    });



    /// myself
    test("getMyFollow", () async{
    List<PinPin?>? list;
    list = await http.getMyFollow();
    print(list);
    });
    test("getMySelf", () async{
    List<PinPin>? list;
    list = await http.getMyPinPin();
    print(list);
    });


    /// notice
    test("getNotice", () async{
      List<Notice>? list;
      list = await http.getNotice();
      print(list);
    });
    test("read", () async{
      MsgResponse? msg;
      msg = await http.readNotice(id: 5);
      print(msg);
    });

    ///sys_notice
    test("getMySysNotice", () async{
      List<Notice>? notices;
      notices = await http.getMySysNotice();
      print(notices);
    });
    test("read", () async{
      MsgResponse? msg;
      msg = await http.createSysNotice(title: "test", content: "test", email: "U202013777"); //?
      print(msg);
    });

  });
}