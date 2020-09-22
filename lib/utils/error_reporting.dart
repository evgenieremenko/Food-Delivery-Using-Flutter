import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';

import 'package:package_info/package_info.dart';
import 'package:sentry/sentry.dart';
import 'package:takein/models/custom_takein_exception.dart';
import 'package:takein/utils/settings.dart';
import 'package:takein/utils/.env.dart';
import '../utils/global.dart' as Global;
import '../main.dart';

SentryClient _sentryClient;
Future<SentryClient> _initSentry() async {
  return SentryClient(
    dsn: Global.domainEnv == "dev"
        ? environmentDev['sentry']
        : environment['sentry'],
    environmentAttributes: await _environmentEvent,
  );
}

Future<SentryClient> getSentryClient() async {
  return _sentryClient ??= await _initSentry();
}

Future<Event> get _environmentEvent async {
  final packageInfo = await PackageInfo.fromPlatform();
  final deviceInfoPlugin = DeviceInfoPlugin();
  OperatingSystem os;
  Device device;

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfoPlugin.androidInfo;
    os = OperatingSystem(
      name: 'android',
      version: androidInfo.version.release,
    );
    device = Device(
      model: androidInfo.model,
      manufacturer: androidInfo.manufacturer,
      modelId: androidInfo.product,
    );
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfoPlugin.iosInfo;
    os = OperatingSystem(
      name: iosInfo.systemName,
      version: iosInfo.systemVersion,
    );
    device = Device(
      model: iosInfo.utsname.machine,
      family: iosInfo.model,
      manufacturer: 'Apple',
    );
  }
  Map<String, String> tags = {};
  tags['platform'] =
      defaultTargetPlatform.toString().substring('TargetPlatform.'.length);
  tags['package_name'] = packageInfo.packageName;
  tags['build_number'] = packageInfo.buildNumber;
  tags['version'] = packageInfo.version;
  tags['uid'] = Global.loginUid;
  final environment = Event(
    release: '${packageInfo.version} (${packageInfo.buildNumber})',
    tags: tags,
    contexts: Contexts(
      operatingSystem: os,
      device: device,
      app: App(
        name: packageInfo.appName,
        version: packageInfo.version,
        build: packageInfo.buildNumber,
      ),
    ),
    userContext: User(
      id: Global.loginUid,
    ),
  );
  return environment;
}

void flutterOnErrorHandler(FlutterErrorDetails details) {
  if (reportCrashes == true) {
    // vHanda: This doesn't always call our zone error handler, why?
    // Zone.current.handleUncaughtError(details.exception, details.stack);
    reportError(details.exception, details.stack);
  } else {
    FlutterError.dumpErrorToConsole(details);
  }
}

bool get reportCrashes => _reportCrashes ??= _initReportCrashes();
bool _reportCrashes;
bool _initReportCrashes() {
  return !TakeIn.isInDebugMode && Settings.instance.collectCrashReports;
}

Future<void> initCrashlytics() async {
  if (reportCrashes) {
    await FlutterCrashlytics().initialize();
  }
}

Future<void> reportError(Object error, StackTrace stackTrace) async {
  if (reportCrashes) {
    captureSentryException(error, stackTrace);
  }

  print("Exception sent: $error");
  print(stackTrace);
}

Future<void> logException(dynamic e, StackTrace stackTrace) async {
  if (!reportCrashes) {
    return;
  }

  await captureSentryException(e, stackTrace);
  return FlutterCrashlytics().logException(e, stackTrace);
}

List<Breadcrumb> breadcrumbs = [];

void captureErrorBreadcrumb({
  @required String name,
  Map<String, dynamic> parameters,
}) {
  var b = Breadcrumb(name, DateTime.now(), data: parameters);
  breadcrumbs.add(b);
}

Future<void> captureSentryException(
  Object exception,
  StackTrace stackTrace,
) async {
  try {
    final sentry = await getSentryClient();
    final Event event = Event(
        exception: exception,
        stackTrace: stackTrace,
        breadcrumbs: breadcrumbs,
        tags: exception is CustomTakeInException
            ? {"severity": "critical"}
            : null);

    return sentry.capture(event: event);
  } catch (e) {
    print("Failed to report with Sentry: $e");
  }
}
