/// pinpin - platform_api
/// Created by xhz on 27/07/2022

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

typedef SelectNotificationCallback = void Function(String? payload);

class PlatformApi {
  static const _pluginName = 'xhzq/platform/api';

  static const _channel = MethodChannel(_pluginName);

  static late final SelectNotificationCallback _onSelectNotification;

  static Future<void> setSelectNotificationCallback(SelectNotificationCallback onSelectNotification) async {
    _onSelectNotification = onSelectNotification;
    WidgetsFlutterBinding.ensureInitialized();
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
      _Method.imageIsExist.name,
      {
        'filename': filename,
      },
    );
    return true == result;
  }

  static Future<void> toast(String content, {bool isLong = false}) async {
    await _channel.invokeMethod(
      _Method.toast.name,
      {
        'content': content,
        'isLong': isLong,
      },
    );
  }

  static Future<int> get buildVersion async {
    final result = await _channel.invokeMethod(_Method.getBuildVersion.name);
    return result as int;
  }

  static Future<String> get appVersion async {
    final result = await _channel.invokeMethod(_Method.getAppVersion.name);
    return result as String;
  }

  static Future<bool> urlLaunch(String url) async {
    final result = await _channel.invokeMethod(_Method.urlLaunch.name, {
      'url': url,
    });
    return result as bool;
  }

  static Future<bool> updateApp(String url, String versionTag) async {
    final result = await _channel.invokeMethod(
      _Method.updateApp.name,
      {
        'url': url,
        'versionTag': versionTag,
      },
    );
    return result as bool;
  }

  static Future<bool> notification(int id, String title, String body, String? payload) async {
    final result = await _channel.invokeMethod(
      _Method.notification.name,
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
        _Method.saveImage.name,
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

enum _Method {
  imageIsExist,
  toast,
  getBuildVersion,
  getAppVersion,
  urlLaunch,
  updateApp,
  notification,
  saveImage;
}
