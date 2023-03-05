library platform;

import 'dart:io';
import 'package:flutter/services.dart';

typedef SelectNotificationCallback = void Function(String? payload);

class PlatformApi {
  static const _pluginName = 'xhzq/platform/api';

  static const _channel = MethodChannel(_pluginName);

  static late final SelectNotificationCallback _onSelectNotification;

  static Future<void> setSelectNotificationCallback(
      SelectNotificationCallback onSelectNotification) async {
    _onSelectNotification = onSelectNotification;
    _channel.setMethodCallHandler(_handleMethod);
  }

  static Future<void> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'selectNotification':
        _onSelectNotification.call(call.arguments);
        break;
      default:
        return await Future<void>.error('Method not defined');
    }
  }

  static Future<bool> imageIsExist(String filename) async {
    final result = await _channel.invokeMethod(
      _Method.imageIsExist,
      {
        'filename': filename,
      },
    );
    return true == result;
  }

  static Future<void> toast(String content, {bool isLong = false}) async {
    await _channel.invokeMethod(
      _Method.toast,
      {
        'content': content,
        'isLong': isLong,
      },
    );
  }

  static Future<int> get buildVersion async {
    final result = await _channel.invokeMethod(_Method.getBuildVersion);
    return result as int;
  }

  static Future<String> get appVersion async {
    if (!Platform.isAndroid) return '1.0.0';
    final result = await _channel.invokeMethod(_Method.getAppVersion);
    return result as String;
  }

  static Future<bool> urlLaunch(String url) async {
    final result = await _channel.invokeMethod(_Method.urlLaunch, {
      'url': url,
    });
    return result as bool;
  }

  static Future<bool> updateApp(String url, String versionTag) async {
    final result = await _channel.invokeMethod(
      _Method.updateApp,
      {
        'url': url,
        'versionTag': versionTag,
      },
    );
    return result as bool;
  }

  static Future<bool> notification(
      int id, String title, String body, String? payload) async {
    final result = await _channel.invokeMethod(
      _Method.notification,
      {
        'id': id,
        'title': title,
        'body': body,
        'payload': payload ?? '',
      },
    );
    return result as bool;
  }

  static Future<bool?> saveImage(Uint8List imageBytes, String filename) async {
    try {
      final result = await _channel.invokeMethod(
        _Method.saveImage,
        {
          'imageBytes': imageBytes,
          'filename': filename,
        },
      );
      if (result) toast('Save success');
      return result;
    } on PlatformException {
      toast('Save failed');
      return null;
    }
  }
}

class _Method {
  static const imageIsExist = 'imageIsExist';
  static const toast = 'toast';
  static const getBuildVersion = 'getBuildVersion';
  static const getAppVersion = 'getAppVersion';
  static const urlLaunch = 'urlLaunch';
  static const updateApp = 'updateApp';
  static const notification = 'notification';
  static const saveImage = 'saveImage';
}
