import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:takein/models/profile.dart';
import 'package:takein/models/promotional_dish.dart';

import '../models/food_model.dart';

//Color
const Color fontColor = Color.fromARGB(255, 44, 60, 77);
const Color borderColor = Color.fromARGB(50, 44, 60, 77);
const Color borderSelectedColor = Color.fromARGB(255, 00, 183, 41);
const Color selectedRedColor = Color.fromARGB(255, 216, 17, 108);
const Color backColor = Color.fromARGB(255, 246, 250, 254);

const Color brightGreenColor = Color(0xFFC1D621);
const Color darkGreenColor = Color(0xFF00B729);
const Color redColor = Color(0xFFD8116C);
const Color redColorLight = Color(0xFFd63002);
const Color darkGreyColor = Color(0xFF92A3B4);
const Color solidDarkGreyColor = Color(0xFF59636e);
const Color darkBlackColor = Color(0xFF000000);

const Color lightGreyColor = Color(0xFF94A5B6);
const Color lightBackgroundColor = Color(0xFFF6FAFE);
const Color borderColorLight = Color.fromRGBO(148, 165, 182, 0.3);

// const TextStyle textSyle;

//Style
const TextStyle textStyle = TextStyle(
    fontSize: 13,
    fontFamily: "Gotham",
    fontWeight: FontWeight.normal,
    color: fontColor);
const TextStyle textStyleBold = TextStyle(
    fontSize: 13,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: fontColor);
const TextStyle textStyleBoldGreen = TextStyle(
    fontSize: 13,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: darkGreenColor);
const TextStyle textStyleBoldGrey = TextStyle(
    fontSize: 15,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: darkGreyColor);
const TextStyle smallTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: "Gotham",
    fontWeight: FontWeight.normal,
    color: fontColor);
const TextStyle titleStyle = TextStyle(
    fontSize: 15,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: fontColor);
const TextStyle smallTitleStyle = TextStyle(
    fontSize: 12,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: fontColor);

const TextStyle textStyleLightGrey = TextStyle(
    fontSize: 13,
    fontFamily: "Gotham",
    fontWeight: FontWeight.normal,
    color: lightGreyColor);
const TextStyle textStyleLightGreyBold = TextStyle(
    fontSize: 13,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: lightGreyColor);
const TextStyle textStyleLightGreyItalic = TextStyle(
    fontSize: 13,
    fontFamily: "Gotham",
    fontStyle: FontStyle.italic,
    color: lightGreyColor);
const TextStyle smallTextStyleLightGrey = TextStyle(
    fontSize: 12,
    fontFamily: "Gotham",
    fontWeight: FontWeight.normal,
    color: lightGreyColor);
const TextStyle titleStyleLightGrey = TextStyle(
    fontSize: 15,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: lightGreyColor);
const TextStyle smallTitleStyleLightGrey = TextStyle(
    fontSize: 12,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: lightGreyColor);

const TextStyle titleStyleWhite = TextStyle(
    fontSize: 15,
    fontFamily: "Gotham",
    fontWeight: FontWeight.bold,
    color: Colors.white);

const BoxDecoration boxDecoration = BoxDecoration(
  color: Colors.white,
  shape: BoxShape.rectangle,
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, 2.0),
      blurRadius: 5.0,
    ),
  ],
);

//Padding
const double padding = 10.0;
const double topMargin = 20.0;

//size
const double topBarHeight = 50;
const double bottomBarHeight = 56; //const from navigation bar
const double tabBarHeight = 50;
const double tabViewHeight = 200;

const double DEFAULT_CAROUSEL_HEIGHT = 190;
const double DEFAULT_CARD_HEIGHT  = 130.0;

//callback
typedef StateCallback = void Function();
typedef SearchFilterCallback = void Function(
    bool, String, double, RangeValues, double, String, List<bool>, List<bool>);
typedef FoodDetailCallback = void Function(FoodSource);
typedef ChefDetailCallback = void Function(Profile);
typedef ShowMessageWindow = void Function(Profile);
typedef FilterStateCallback = void Function(bool);
typedef PositionStateCallback = void Function(Prediction);
typedef MapStateCallback = void Function(bool, int);
typedef PromotionalCallback = void Function(PromotionalDish, String);

bool notNull(Object o) => o != null;

String loginUid;
bool bIsProducer = false;
String lastOrderId;
bool bIsOrdered = false;
String domainEnv;
String stripeClientId;
String stripePublishKey;
String recentVersion;
String currentVersion;
bool bIsVersionChecked = false;

int currentProfileState = 0;

List<String> addressList = [];
List<LatLng> locationList = [];

LatLng currentLocationLatLng;
List<CartModel> reservedCartList;

//API_KEY
const kGoogleApiKey = "AIzaSyC0uvdLGD4rGMkrMec_LSXUeWCbbGAvnBw";

const cachedDataInMinutes = 10;
