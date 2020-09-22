# Food Delivery Using Flutter

# Run
flutter run --flavor dev

### for localization

`flutter packages pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/utils/localization.dart`

`flutter packages pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/utils/localization.dart lib/l10n/intl_en.arb lib/l10n/intl_es.arb lib/l10n/intl_messages.arb`

# Testing (in progress)
> Unit test:  
 
Inside the folder test run the test files

> Integration test:  

Use the test_driver folder, if we want to run the test we should execute: flutter drive --target=test_driver/app.dart  

> Automation test: (Appium)  

We need to use the appium-flutter-driver, folllow all the instructions: https://github.com/truongsinh/appium-flutter-driver  
After we have appium ready we should create the file of the platform that we want to test: flutter build apk --flavor dev (Android)  
Also we must:
 - Start Appium locally
 - Run npm install inside appium folder in our project
 - Run an emulator or simulator that matches with the devices names included inside test.js file
 - Run: APPIUM_OS=android npm start 




# Git Tagging
git tag -a v1.0.0 -m "hide homechef related items"


## Color Codes
Dark grey (instead of grey): 92A3B4
Red / pink: D8116C
Green dark: BEC800
Green bright: C1D621

# Before run, 
* uncomment hive_generator
* comment flutter_driver, test, flutter_test
* set dartx: ^0.2.0
  
flutter pub run build_runner build --define "json_serializable=any_map=true" --delete-conflicting-outputs


curl https://sentry.io/api/hooks/release/builtin/5205990/c2c43dae169222c8ba09ae56ba8800da2f92cde2ebb551a3f31bb98acea627ac/ \
  -X POST \
  -H 'Content-Type: application/json' \
  -d '{"version": "1.4.2"}'

