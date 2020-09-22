import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'blocs/blocs.dart';
import 'services/resources/takein_api.dart';
import 'services/resources/takein_api_provider.dart';
import 'services/resources/repository.dart';
import 'utils/takein_log.dart';

import 'package:takein/utils/global.dart' as Global;


List<SingleChildWidget> getProviders() {
  return [
    remoteConfigProvider,
    ...independentServices,
    ...dependentServices,
    ...uiConsumableProviders,
  ];
}

List<SingleChildWidget> independentServices = [
  Provider<Repository>.value(value: Repository()),
  Provider<TakeInApi>.value(value: TakeInApiProvider()),
  //ChangeNotifierProvider.value(value: RemoteConfigBloc()),
  StreamProvider<FirebaseUser>.value(
      value: FirebaseAuth.instance.onAuthStateChanged),
];

List<SingleChildWidget> dependentServices = [
  ChangeNotifierProvider.value(value: GlobalBloc()),
  ChangeNotifierProvider.value(value: ProfileBloc()),
  ChangeNotifierProvider.value(value: UserProfileBloc()),
  ChangeNotifierProvider.value(value: LocationBloc()),
];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider.value(value: OrderBloc()),
  ChangeNotifierProvider.value(value: CartBloc()),
  ChangeNotifierProvider.value(value: SearchBloc()),
  ChangeNotifierProvider.value(value: ValueNotifier<bool>(false)),
];

FutureProvider<RemoteConfig> remoteConfigProvider =
    FutureProvider<RemoteConfig>(
  create: (_) async => initializeRemoteConfig(),
  lazy: false,
);

Future<RemoteConfig> initializeRemoteConfig() async {
  tlog.debug("Initializing RemoteConfig");
  final remoteConfig = await RemoteConfig.instance;
  try {
    await remoteConfig.fetch(expiration: const Duration(minutes: 30));
    await remoteConfig.activateFetched();
  } catch (e) {
    tlog.error("Unable to connect to remote config:", e);
    //throw FlutterError(e);
    return remoteConfig;
  }

  final all = remoteConfig.getAll();
  String domainEnv = remoteConfig?.getString("domain_env");

  Global.domainEnv = domainEnv ?? 'dev';

  tlog.debug('---------- All Config : $all');

  return remoteConfig;
}
