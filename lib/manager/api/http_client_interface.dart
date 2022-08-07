/// pinpin - http_client_interface
/// Created by xhz on 30/07/2022
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pinpin/component/loading/loading.dart';
import 'package:pinpin/component/toast/toast.dart';
import 'package:pinpin/manager/api/api.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:pinpin/util/logger.dart';

typedef Decoder<T> = T Function(dynamic);

abstract class HttpClientInterface {
  late final Dio _dio = createDio();
  static const _authHeaderName = 'Authorization';

  Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Api.head,
      receiveTimeout: 15000,
      connectTimeout: 15000,
      sendTimeout: 15000,
      responseType: ResponseType.json,
    ));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      Loading.show();
      final token = accountGetter.call()?.token;
      if (null != token) {
        options.headers[_authHeaderName] = token;
      }
      log('REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      Loading.hide();
      log('RESPONSE[${response.statusCode}] => DATA: ${response.data} ');
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      Loading.hide();
      if (e.response == null) {
        toast('Network unavailable');
      } else {
        final String? msg = e.response?.data['msg'];
        toast(msg ?? 'Request Failed');
        log(msg ?? 'Request Failed');
      }
      handler.reject(e);
    }));

    return dio;
  }

  final String deviceName;
  final UserInfo? Function() accountGetter;
  final void Function(UserInfo userInfo) accountUpdater;

  HttpClientInterface.init({
    required this.deviceName,
    required this.accountGetter,
    required this.accountUpdater,
  });

  Future<T?> request<T>(
    Api api,
    Decoder<T> decoder, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response? response;
    try {
      response = await _dio.request(api.val,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          options: options?.copyWith(method: api.method) ?? Options(method: api.method));
      return decoder.call(response.data['data']);
    } catch (e) {
      Logger.e('HttpClientInterface.request<$T>, msg:${response?.data['msg']}', e);
      return null;
    }
  }

  Dio get dio => _dio;
}
