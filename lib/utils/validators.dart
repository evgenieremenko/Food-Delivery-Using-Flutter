import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'credit_card_utils.dart';
import 'localization.dart';

class Validators {
  static String validateUserEmail(String value, BuildContext context) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return TakeInLocalizations.of(context).validEmail;
    } else {
      return null;
    }
  }

  static String validateUserPassword(String value, BuildContext context) {
    if (value.length < 5) {
      return TakeInLocalizations.of(context).validPassword;
    } else {
      return null;
    }
  }

  static String validateUserName(String value, BuildContext context) {
    if (value.length < 1) {
      return TakeInLocalizations.of(context).validFullName;
    } else {
      return null;
    }
  }

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
//  static final RegExp _passwordRegExp = RegExp(
//    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
//  );
  static final RegExp _passwordRegExp = RegExp(
    r'^\S{1}(?:.){6,}\S$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isRepeatValidPassword(String password, String repeatPassword) {
    return _passwordRegExp.hasMatch(repeatPassword) &&
        password == repeatPassword;
  }

  static isValidUserName(String userName) {
    return userName.length >= 8 ? true : false;
  }

  final validateField =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data != null && data.length > 1) {
      sink.add(data);
    } else {
      sink.addError("Invalid data");
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
//        if (email.contains('@')) {
//          sink.add(email);
//        } else {
//          sink.addError('Enter a valid email');
//        }
    if (_emailRegExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("Invalid email");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 8 characters');
    }
  });

  final validateCard =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (CardUtils.validateCardNum(data) == null) {
      sink.add(data);
    } else {
      sink.addError("Invalid card");
    }
  });

  final validateCvvCode =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (CardUtils.validateCVV(data) == null) {
      sink.add(data);
    } else {
      sink.addError("Invalid cvv code");
    }
  });

  final validateExpiryMonth =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (CardUtils.validateDate(data) == null) {
      sink.add(data);
    } else {
      sink.addError("Invalid date");
    }
  });
}
