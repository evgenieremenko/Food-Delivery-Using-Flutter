import 'package:flutter/foundation.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'global.dart' as Global;

import '../main.dart';
import 'takein_log.dart';

Analytics getAnalytics() {
  return TakeIn.analytics;
}

class Analytics {
  var firebase = FirebaseAnalytics();
  bool enabled = false;

  Future<void> aLogEvent({
    @required String name,
    Map<String, dynamic> parameters,
  }) async {
    if (parameters == null) {
      parameters = {};
    }
    if (Global.loginUid != null) {
      firebase.setUserId(Global.loginUid);
      parameters['uid'] = Global.loginUid;
    }

    if (parameters["screenName"] != null) {
      firebase.setCurrentScreen(screenName: parameters["screenName"]);
    }
    try {
      await firebase.logEvent(name: name, parameters: parameters);
    } catch (e, s) {
      tlog.error('Unable to send analytics:', e, s);
    }
  }

  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    this.enabled = enabled;
    return firebase.setAnalyticsCollectionEnabled(enabled);
  }
}
