import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

Logger get log => Logger();

class Logger {
  // Singleton pattern with factory constructor
  Logger._internal();
  static final Logger _singleton = Logger._internal();

  factory Logger() {
    return _singleton;
  }

  /// param [msg] is the message to be logged to the console
  void info(String msg) {
    blue(msg);
  }

  /// param [msg] is the message to be logged to the console
  void success(String msg) {
    green(msg);
  }

  /// param [msg] is the message to be logged to the console
  void warning(String msg) {
    yellow(msg);
  }

  /// param [msg] is the message to be logged to the console
  void error(String msg) {
    red(msg);
  }

  void white(String msg) {
    if (kDebugMode) developer.log('\x1B[37m$msg\x1B[0m');
  }

  /// param [msg] is the message to be logged to the console
  void red(String msg) {
    if (kDebugMode) developer.log('\x1B[31m$msg\x1B[0m');
  }

  /// param [msg] is the message to be logged to the console
  void green(String msg) {
    if (kDebugMode) developer.log('\x1B[32m$msg\x1B[0m');
  }

  /// param [msg] is the message to be logged to the console
  void yellow(String msg) {
    if (kDebugMode) developer.log('\x1B[33m$msg\x1B[0m');
  }

  /// param [msg] is the message to be logged to the console
  void blue(String msg) {
    if (kDebugMode) developer.log('\x1B[34m$msg\x1B[0m');
  }

  /// param [msg] is the message to be logged to the console
  void cyan(String msg) {
    if (kDebugMode) developer.log('\x1B[36m$msg\x1B[0m');
  }
}
