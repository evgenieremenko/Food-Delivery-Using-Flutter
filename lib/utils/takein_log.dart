import 'package:fimber/fimber.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:takein/utils/common_utils.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../utils/global.dart' as Global;
import 'error_reporting.dart';

TakeinLog tlog = TakeinLog();

class TakeinLog {
  bool printToConsole = false;
  static Future<void> init() async {
    if (foundation.kDebugMode) {
      Fimber.plantTree(DebugTree.elapsed(useColors: true));
    } else {
      Fimber.plantTree(DebugTree.elapsed(useColors: false));
    }
  }

  void debug(String message) {
    if (Global.domainEnv != 'com') {
      List<String> frames = Trace.current().frames[1].member.split(".");
      final className = frames.length > 0 ? frames[0] : "";
      final methodName = frames.length > 1 ? frames[1] : "";
      Fimber.log("D", message, tag: '$className.$methodName');
    }
  }

  void info(String message) {
    if (Global.domainEnv == 'dev') {
      List<String> frames = Trace.current().frames[1].member.split(".");
      final className = frames.length > 0 ? frames[0] : "";
      final methodName = frames.length > 1 ? frames[1] : "";
      Fimber.log("I", message, tag: '$className.$methodName');
    }
  }

  void error(String message, [dynamic e, StackTrace s]) async {
    List<String> frames = Trace.current().frames[1].member.split(".");
    final className = frames.length > 0 ? frames[0] : "";
    final methodName = frames.length > 1 ? frames[1] : "";

    Fimber.log("E", message,
        ex: e, stacktrace: s, tag: '$className.$methodName');

    sendAnalytics("exception", {"description": message});
    if (e != null) {
      reportError(e, s);
    }
  }

  void warn(String message) {
    List<String> frames = Trace.current().frames[1].member.split(".");
    final className = frames.length > 0 ? frames[0] : "";
    final methodName = frames.length > 1 ? frames[1] : "";

    Fimber.w('($className.$methodName): $message');
  }
}
