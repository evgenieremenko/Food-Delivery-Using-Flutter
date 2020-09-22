import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() async {
  UserModel _userModel;

  StreamController<UserModel> _controller;

  setUp(() {
    _controller = StreamController<UserModel>();
    _userModel = UserModel(email: "robert@takein.com", password: "12345678");
  });

  group('Sign In - [User Model] ', () {
    test('[Model] Check individual values', () async {
      _userModel = UserModel(
        email: 'robert@takein.com',
        password: '12345678',
      );

      // BEGIN TESTS....
      expect(_userModel.email, 'robert@takein.com');

      expect(_userModel.email, contains('@'));

      expect(_userModel.password, isNotNull);

      expect(_userModel.password.length > 6, _userModel.password.length > 6);
    });

    testWidgets('[Provider] Update when the value changes', (tester) async {
      final _providerKey = GlobalKey();

      final _childKey = GlobalKey();

      BuildContext context;

      await tester.pumpWidget(StreamProvider(
        key: _providerKey,
        create: (c) {
          context = c;
          return _controller.stream;
        },
        child: Container(key: _childKey),
      ));

      // Check the context test...
      expect(context, equals(_providerKey.currentContext));

      // Check the model test (if null)...
      expect(Provider.of<UserModel>(_childKey.currentContext), null);

      _controller
          .add(UserModel(email: "robert@takein.com", password: "12345678"));

      // Delay the pump...
      await Future.microtask(tester.pump);

      // Check if the model passed (with some value) is the same as received...
      expect(
        Provider.of<UserModel>(_childKey.currentContext).toJson(),
        _userModel.toJson(),
      );

      await _controller.close();
    });
  });

  //We can't get the context here, so we should create a widget test
//  BuildContext context;
//
//  test('empty email returns error string', () {
//    final result = Validators.validateUserEmail('', context);
//    expect(result, TakeInLocalizations.of(context).validEmail);
//  });
//
//  test('non-empty email returns null', () {
//    final result = Validators.validateUserEmail('exampleemail@takein.com', context);
//    expect(result, null);
//  });
//
//  test('empty password returns error string', () {
//    final result = Validators.validateUserPassword('', context);
//    expect(result, TakeInLocalizations.of(context).validPassword);
//  });
//
//  test('non-empty password returns null', () {
//    final result = Validators.validateUserPassword('password', context);
//    expect(result, null);
//  });
//
//  test('empty name returns error string', () {
//    final result = Validators.validateUserName('', context);
//    expect(result, TakeInLocalizations.of(context).validPassword);
//  });
//
//  test('non-empty user name returns null', () {
//    final result = Validators.validateUserName('Peter', context);
//    expect(result, null);
//  });
}

class UserModel {
  String email;
  String password;

  UserModel({this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
