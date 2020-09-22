import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:takein/models/menu_model.dart';

import 'package:takein/models/last_call.dart';
import 'package:takein/models/profile.dart';
import 'package:takein/models/user_location.dart';
import 'package:takein/services/journal_events_logs_service.dart';
import 'package:takein/utils/takein_log.dart';
import 'models/food_model.dart';
import 'models/models.dart';
import 'models/promotional_dish.dart';
import 'providers_setup.dart';
import 'services/conectivity_service.dart';
import 'ui/screens/screens.dart';
import 'routes/router.dart';
import 'blocs/blocs.dart';
import 'utils/analytics.dart';

import 'utils/error_reporting.dart';
import 'utils/utils.dart';
import 'utils/settings.dart' as tk;

void main() async {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.

  await Hive.initFlutter();
  await TakeinLog.init();

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = flutterOnErrorHandler;
  Provider.debugCheckInvalidValueType = null;

//  enableFlutterDriverExtension();

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initCrashlytics();
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();

    Hive
      ..init(appDocumentDir.path)
      ..registerAdapter(ProfileAdapter())
      ..registerAdapter(MenuModelAdapter())
      ..registerAdapter(AddressAdapter())
      ..registerAdapter(SettingsAdapter())
      ..registerAdapter(FoodModifiersAdapter())
      ..registerAdapter(FoodModOptionsAdapter())
      ..registerAdapter(ChefAdapter())
      ..registerAdapter(FoodSourceAdapter())
      ..registerAdapter(LastCallAdapter())
      ..registerAdapter(LastCallDishAdapter())
      ..registerAdapter(LastCallLocationAdapter())
      ..registerAdapter(UserLocationAdapter())
      ..registerAdapter(ProfileMetaAdapter())
      ..registerAdapter(PromotionalDishAdapter());

    await initCache();
    if (tk.Settings.instance.collectUsageStatistics) {
      _enableAnalyticsIfPossible();
    }

    runApp(TakeIn());
  }, (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    //debugPrint(error.toString());
    tlog.error("reportCrash: ", error, stackTrace);
    return logException(error, stackTrace);
    //return Crashlytics.instance.recordError(error, stackTrace);
  });
}

Future<void> initCache() async {
  try {
    await Hive.openBox('user');
  } catch (e) {
    Hive.deleteBoxFromDisk('user');
    await Hive.openBox('user');
  }
  try {
    await Hive.openBox('chefs');
  } catch (e) {
    Hive.deleteBoxFromDisk('chefs');
    await Hive.openBox('chefs');
  }
  try {
    await Hive.openBox('dishes');
  } catch (e) {
    Hive.deleteBoxFromDisk('dishes');
    await Hive.openBox('dishes');
  }
  try {
    await Hive.openBox('menus');
  } catch (e) {
    Hive.deleteBoxFromDisk('menus');
    await Hive.openBox('menus');
  }
  try {
    await Hive.openBox('lastCalls');
  } catch (e) {
    Hive.deleteBoxFromDisk('lastCalls');
    await Hive.openBox('lastCalls');
  }
  try {
    await Hive.openBox('promotions');
  } catch (e) {
    Hive.deleteBoxFromDisk('promotions');
    await Hive.openBox('promotions');
  }
}

void _enableAnalyticsIfPossible() async {
  var isPhysicalDevice = true;
  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var info = await deviceInfo.androidInfo;
      isPhysicalDevice = info.isPhysicalDevice;
      tlog.info("Device Fingerprint: " + info.fingerprint);
    } else if (Platform.isIOS) {
      var info = await deviceInfo.iosInfo;
      isPhysicalDevice = info.isPhysicalDevice;
    }
  } catch (e) {
    tlog.error(e);
  }

  bool enabled = !TakeIn.isInDebugMode;

  tlog.debug(
      "Analytics Collection: $enabled isPhysicalDevice: $isPhysicalDevice");
  TakeIn.analytics.setAnalyticsCollectionEnabled(enabled);
}

class TakeIn extends StatefulWidget {
  static final analytics = Analytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics.firebase);
  static bool isInDebugMode = kDebugMode;

  @override
  createState() => _TakeInState();
}

class _TakeInState extends State<TakeIn> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      child: ProfileBlocProvider(
        child: StreamProvider.value(
          value: ConnectivityService().connectionStatusController.stream,
          child: StreamProvider.value(
            value: JournalEventsLogsService().stream,
            child: OverlaySupport(
              child: Consumer<GlobalBloc>(
                builder: (context, value, child) {
                  return MaterialApp(
                    title: "TakeIn",
                    debugShowCheckedModeBanner: false,
                    navigatorObservers: [
                      TakeIn.observer,
                    ],
                    theme: ThemeData(brightness: Brightness.light),
                    localizationsDelegates: [
                      TakeInLocalizationsDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    supportedLocales: [
                      const Locale('en', ''),
                      const Locale('es', ''),
                    ],
                    home: MySplash(),
                    onGenerateRoute: Routes.generateRoute,
                    onUnknownRoute: (settings) => MaterialPageRoute(
                      builder: (_) => Scaffold(
                        body: Center(
                          child: Text('No route defined for ${settings.name}'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MySplash extends StatefulWidget {
  @override
  createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 1,
        title: Text(
          TakeInLocalizations.of(context).splashTitle,
          textScaleFactor: 1.0,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset("assets/images/takein_logo.png"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Takein"),
        loaderColor: Colors.red);
  }
}
