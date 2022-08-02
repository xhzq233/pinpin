/// pinpin - http_client
/// Created by xhz on 27/07/2022
import 'package:dio/dio.dart';
import 'package:pinpin/manager/api/api.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/manager/api/http_client_interface.dart';
import 'package:pinpin/model/pinpin/pinpin_list_data.dart';

class PPHttp extends HttpClientInterface with PPNetWorkInterface {
  PPHttp.init({required super.deviceName, required super.accountGetter, required super.accountUpdater}) : super.init();

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


}
