
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
//import 'package:e2e/e2e.dart';



void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
  MethodChannel('plugins.flutter.io/path_provider');
  final List<MethodCall> log = <MethodCall>[];
  dynamic response;

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    log.add(methodCall);
    return response;
  });

  setUp(() {
//    setMockPathProviderPlatform(FakePlatform(operatingSystem: 'android'));
  });

  tearDown(() {
    log.clear();
  });

  test('getTemporaryDirectory test', () async {
    response = null;
    final Directory directory = await getTemporaryDirectory();
    expect(
      log,
      <Matcher>[isMethodCall('getTemporaryDirectory', arguments: null)],
    );
    expect(directory, isNull);
  });

  test('getApplicationSupportDirectory test', () async {
    response = null;
    final Directory directory = await getApplicationSupportDirectory();
    expect(
      log,
      <Matcher>[
        isMethodCall('getApplicationSupportDirectory', arguments: null)
      ],
    );
    expect(directory, isNull);
  });

//  E2EWidgetsFlutterBinding.ensureInitialized();
//
//  testWidgets('getTemporaryDirectory', (WidgetTester tester) async {
//    final Directory result = await getTemporaryDirectory();
////    _verifySampleFile(result, 'temporaryDirectory');
//    expect(result, notNull);
//  });

}

/// Verify a file called [name] in [directory] by recreating it with test
/// contents when necessary.
void _verifySampleFile(Directory directory, String name) {
  final File file = File('${directory.path}/$name');

  if (file.existsSync()) {
    file.deleteSync();
    expect(file.existsSync(), isFalse);
  }

  file.writeAsStringSync('Hello TakeIn!');
  expect(file.readAsStringSync(), 'Hello TakeIn!');
  expect(directory.listSync(), isNotEmpty);
  file.deleteSync();
}