/// pinpin - logger
/// Created by xhz on 29/07/2022
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static void e(dynamic message, [dynamic error]) {
    _output('[ERROR]', message, _AnsiColor.fg(180), error);
  }

  static void d(
    String message,
  ) {
    _output('[DEBUG]', message, null);
  }

  static void i(dynamic message) {
    _output('[INFO]', message, _AnsiColor.fg(12));
  }

  static void w(dynamic message) {
    _output('[WARN]', message, _AnsiColor.fg(208));
  }

  static void v(dynamic message) {
    _output('[VERBOSE]', message, _AnsiColor.fg(196));
  }

  static void wtf(dynamic message) {
    _output('[WTF]', message, _AnsiColor.fg(199));
  }

  static final void Function(String) print = stdout.hasTerminal
      ? (String str) {
          stdout.write('$str\n');
        }
      : debugPrint;

  static void _output(String label, dynamic content, _AnsiColor? color, [dynamic error]) {
    if (kDebugMode) {
      if (null != color) {
        print(color('$label ${content.toString()}'));
        if (error != null) {
          print(color('$error Error\n${_formatStackTrace(StackTrace.current)}'));
        }
      } else {
        print('$label ${content.toString()}');
        if (error != null) {
          print('$error Error\n${_formatStackTrace(StackTrace.current)}');
        }
      }
    }
  }

  static String _formatStackTrace(StackTrace stackTrace) {
    final line = stackTrace.toString().split('\n').last;
    return line;
  }
}

class _AnsiColor {
  /// ANSI Control Sequence Introducer，向终端发出新设置的信号。
  static const ansiEsc = '\x1b[';

  /// reset
  static const ansiDefault = '${ansiEsc}0m';

  final int? fg;
  final int? bg;

  _AnsiColor.fg(this.fg) : bg = null;

  _AnsiColor.bg(this.bg) : fg = null;

  @override
  String toString() {
    if (fg != null) {
      return '${ansiEsc}38;5;${fg}m';
    } else if (bg != null) {
      return '${ansiEsc}48;5;${bg}m';
    } else {
      return '';
    }
  }

  String call(String msg) {
    return '${this}$msg$ansiDefault';
  }

  _AnsiColor toFg() => _AnsiColor.fg(bg);

  _AnsiColor toBg() => _AnsiColor.bg(fg);

  /// 在不改变背景的情况下默认终端的前景色。
  String get resetForeground => '${ansiEsc}39m';

  /// 在不改变前景的情况下默认终端的背景颜色。
  String get resetBackground => '${ansiEsc}49m';
}
