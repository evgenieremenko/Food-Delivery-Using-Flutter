import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main2() {
  group('Takein', () {
    final productQuantityTextFinder = find.byValueKey('productQuantity');
    final incrementQuantityButtonFinder = find.byValueKey('incrementQuantity');
    final decrementQuantityButtonFinder = find.byValueKey('decrementQuantity');


    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 1', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(productQuantityTextFinder), "1");
    });

    test('increments the product quantity', () async {
      // First, tap the button.
      await driver.tap(incrementQuantityButtonFinder);

      // Then, verify the product quantity text is incremented by 1.
      expect(await driver.getText(productQuantityTextFinder), "2");
    });

    test('decrements the product quantity', () async {
      // First, tap the button.
      await driver.tap(decrementQuantityButtonFinder);

      // Then, verify the product quantity text is decremented by 1.
      expect(await driver.getText(productQuantityTextFinder), "1");
    });

  });
}