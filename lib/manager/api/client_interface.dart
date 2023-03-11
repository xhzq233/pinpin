/// pinpin - http_client_interface
/// Created by xhz on 30/07/2022
import 'package:dio/dio.dart';

import 'package:pinpin/manager/api/api.dart';
import 'package:pinpin/model/account/account.dart';
import 'package:util/logger.dart';

typedef Decoder<T> = T Function(dynamic);
typedef AccountGetter = Account? Function();
typedef AccountUpdater = void Function(Account account);
typedef DataBaseGetter<T> = Future<T?> Function(dynamic);
typedef Toaster = void Function(String);

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

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = accountGetter.call()?.token;
          if (null != token) {
            options.headers[_authHeaderName] = 'Bearer $token';
            // Logger.i('ADD TOKEN ${options.headers[_authHeaderName]}');
          }
          Logger.i(
              'REQ[${options.method}] => PATH: ${options.baseUrl + options.path + options.queryParameters.toString()}, DATA: ${options.data}');
          return handler.next(options); //continue
        },
        onError: (DioError e, handler) {
          if (e.response == null) {
            toaster('Network unavailable');
          } else {
            final String? msg = e.response?.data['msg'].toString() ?? e.response?.data.toString();
            toaster(msg ?? 'Request Failed');
            Logger.e('Request:${e.requestOptions.data} ==> Response: ${e.response}');
          }
          handler.reject(e);
        },
      ),
    );

    return dio;
  }

  final String deviceName;
  final AccountGetter accountGetter;
  final AccountUpdater accountUpdater;
  final Toaster toaster;

  HttpClientInterface.init({
    required this.deviceName,
    required this.accountGetter,
    required this.accountUpdater,
    required this.toaster,
  });

  Future<T?> request<T>(
    Api api,
    Decoder<T> decoder, {
    data,
    String? contentField = 'data',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? jsonReplacement,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response? response;
    try {
      response = await _dio.request(
        api.val,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: options?.copyWith(method: api.method) ?? Options(method: api.method),
      );
      final dynamic json;
      if (null != contentField) {
        json = response.data[contentField];
      } else {
        json = response.data;
      }

      if (jsonReplacement != null && jsonReplacement.isNotEmpty) {
        jsonReplacement.forEach((key, value) {
          json[key] = value;
        });
      }
      Logger.i('RSP[${response.statusCode}] => DATA: ${response.data}');
      return decoder.call(json);
    } catch (e) {
      Logger.e('HttpClientInterface.request<$T>, response:\n${response?.data}', e);
      return null;
    }
  }

  Future<T?> requestForUserInfo<T>(
    Api api,
    Decoder<T> decoder, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      request(
        api,
        decoder,
        contentField: 'info',
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<T?> requestForMsg<T>(
    Api api,
    Decoder<T> decoder, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      request(
        api,
        decoder,
        contentField: null,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<List<T>?> requestList<T>(
    Api api,
    Decoder<T> decoder, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      request(
        api,
        (list) => (list as List<dynamic>).map((e) => decoder.call(e)).toList(growable: false),
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
}
