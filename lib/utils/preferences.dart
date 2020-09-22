import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TakeInSharedPreference {
  final String _userMail = "user_email";
  final String _userPassword = "user_password";
  final String _userfirstname = "user_first_name";
  final String _userlastname = "user_last_name";
  final String _userphonenumber = "user_phone_number";

  Future<String> getUserEmail() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(_userMail);
  }

  Future<bool> setUserEmail(String userMail) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.setString(_userMail, userMail);
  }

  Future<String> getPassword() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(_userPassword);
  }

  Future<bool> setPassword(String password) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.setString(_userPassword, password);
  }

  Future<String> getUserFirstName() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_userfirstname);
  }

  Future<String> getUserLastName() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_userlastname);
  }

  Future<String> getUserPhoneNumber() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_userphonenumber);
  }

}
