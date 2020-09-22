const wdio = require('webdriverio');
const assert = require('assert');
const find = require('appium-flutter-finder');

const osSpecificOps = process.env.APPIUM_OS === 'android' ? {
  platformName: 'Android',
//  deviceName: 'emulator-5554',
  deviceName: 'RF8M92X962Y',
  app: __dirname +  '/../build/app/outputs/apk/dev/release/app-dev-release.apk',
} : process.env.APPIUM_OS === 'ios' ? {
  platformName: 'iOS',
  platformVersion: '13.3',
//  deviceName: 'iPhone 11 Pro Max',
  deviceName: 'af7486d829711c96bebd0ccdd8e2d281ebd4825b',
  noReset: true,
//  app: __dirname +  '/../ios/Runner.zip',
  app: __dirname +  '/../build/ios/iphoneos/Runner.app',

} : {};

const opts = {
  port: 4723,
  capabilities: {
    ...osSpecificOps,
//    automationName: 'Flutter'
  }
};

(async () => {
  console.log('Initial app testing')
  const driver = await wdio.remote(opts);
//  assert.strictEqual(await driver.execute('flutter:checkHealth'), 'ok');
//  await driver.execute('flutter:clearTimeline');
//  await driver.execute('flutter:forceGC');

  //Enter login page
  await driver.execute('flutter:waitFor', find.byValueKey('signInButton'));
  await driver.elementSendKeys(find.byValueKey('emailSignIn'), 'test@gmail.com')
  await driver.elementSendKeys(find.byValueKey('passwordSignIn'), '123456')
  await driver.elementClick(find.byValueKey('signInButton'));


  //Enter sign up page
  await driver.execute('flutter:waitFor', find.byValueKey('signUpButton'));
  await driver.elementSendKeys(find.byValueKey('emailSignUp'), 'test@gmail.com')
  await driver.elementSendKeys(find.byValueKey('nameSignUp'), 'Test')
  await driver.elementSendKeys(find.byValueKey('passwordSignUp'), '123456')
  await driver.elementClick(find.byValueKey('signUpButton'));


  //Enter home page
//  await driver.execute('flutter:waitFor', find.byValueKey('homeGreetingLbl'));
//  assert.strictEqual(await driver.getElementText(find.byValueKey('homeGreetingLbl')), 'Welcome to Home TakeIn');

  //Enter Page1
//  await driver.elementClick(find.byValueKey('page1Btn'));
//  await driver.execute('flutter:waitFor', find.byValueKey('page1GreetingLbl'));
//  assert.strictEqual(await driver.getElementText(find.byValueKey('page1GreetingLbl')), 'Page1');
//  await driver.elementClick(find.byValueKey('page1BackBtn'));
//
//  //Enter Page2
//  await driver.elementClick(find.byValueKey('page2Btn'));
//  await driver.execute('flutter:waitFor', find.byValueKey('page2GreetingLbl'));
//  assert.strictEqual(await driver.getElementText(find.byValueKey('page2GreetingLbl')), 'Page2');
//  await driver.switchContext('NATIVE_APP');
//  await driver.back();
//  await driver.switchContext('FLUTTER');
//
//  //Logout application
//  await driver.elementClick(find.byValueKey('logoutBtn'));
  driver.deleteSession();
})();