import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:takein/blocs/blocs.dart';
import 'package:takein/main.dart';
import 'package:takein/models/models.dart';
import 'package:takein/services/resources/repository.dart';
import 'package:takein/utils/custom_snack_bar.dart';
import 'package:takein/utils/takein_log.dart';
import 'package:libphonenumber/libphonenumber.dart';

import '../models/profile.dart';
import 'conectivity_status.dart';
import 'global.dart' as Global;
import 'localization.dart';

final DateFormat format = DateFormat("yyyy/M/dd h:mm a");
final timeFormat = DateFormat('hh:mm a');

//FirebaseAnalytics analytics = FirebaseAnalytics();

const String CARD_ADDED_SUCCESSFULLY = "CARD_ADDED_SUCCESSFULLY";
const String CARD_ADDED_WAITING = "Waiting";
const String CARD_ADDED_ERROR = "Error saving card, please try again";
const String CARD_TIMEOUT = "Timeout";

final Map<String, dynamic> productSvgMap = {
  "default_fork": "noun_fork_656544.svg",
  "default": "noun_Food_3073486.svg",
  "pizza": "noun_pizza_slice_1204550.svg",
  "fries": "noun_Fries_2244726.svg",
  "appetizer": "noun_Appetizers_2570702.svg",
  "burger": "noun_Burger_3116470.svg",
  "stew": "noun_Salad_2293197.svg",
  "salad": "noun_Salad_2293197.svg",
  "sushi": "noun_Sushi_3243069.svg",
  "pasta": "noun_farfalle_pasta_1989654.svg",
  "noodle": "noun_noddle_2472120.svg",
  "steak": "noun_Steak_94154.svg",
  "breakfast": "noun_Breakfast_671128.svg",
  "taco": "noun_Taco_1773943.svg",
  "burrito": "noun_burrito_95674.svg",
  "seafood": "noun_seafood_1035431.svg",
  "lollipop": "noun_Lollipop_1592420.svg",
  "rice": "noun_rice_1556443.svg",
  "sandwich": "noun_sub_sandwich_1553033.svg",
  "ice_cream": "noun_Ice_Cream_Cone_1546073.svg",
  "dessert": "noun_Ice_Cream_Cone_1546073.svg",
  "skewer": "noun_skewer_1030066.svg",
  "tea": "noun_Tea_cup_1022241.svg",
  "cake": "noun_Cake_3216848.svg",
  "barbacue": "noun_barbacue_2663387.svg",
  "bbq": "noun_barbacue_2663387.svg",
  "chicken": "noun_Chicken_1581885.svg",
  "drink": "noun_Drink_3224515.svg",
  "global_price_discount": "noun_Coupon_2919491.svg",
  "global_delivery_discount": "noun_free_delivery_2508039.svg",
  "delivery_option": "noun_Truck_3370094.svg",
};
Map<String, SvgPicture> productSvgCache = {};

String parseDateTimeInIso(String date, time) {
  DateTime combine = format.parse("$date $time");
  String dPart = combine.toIso8601String().substring(0, 19);
  String zPart = "";
  if (combine.timeZoneOffset.inHours < 0)
    zPart = sprintf("%03i:%02i", [
      combine.timeZoneOffset.inHours,
      combine.timeZoneOffset.inMinutes.remainder(60)
    ]);
  else {
    zPart = sprintf("+%02i:%02i", [
      combine.timeZoneOffset.inHours,
      combine.timeZoneOffset.inMinutes.remainder(60)
    ]);
  }

  return "$dPart$zPart";
}

/// Returns time services from given from, to and interval params
/// From 'from' to 'to' every 15 minutes

List<String> generateTimeSeries(
    DateTime from, DateTime to, int interval, bool bIsSameDay) {
  List<String> list = <String>[];

  if (bIsSameDay) {
    int minutes = from.minute;
    if (minutes <= 15) {
      from = from.add(Duration(minutes: 15 - from.minute));
    } else if (minutes <= 30) {
      from = from.add(Duration(minutes: 30 - from.minute));
    } else if (minutes <= 45) {
      from = from.add(Duration(minutes: 45 - from.minute));
    } else {
      from = from.add(Duration(minutes: 60 - from.minute));
    }
  }

  for (var i = 0; from.add(Duration(minutes: i * interval)).isBefore(to); i++) {
    list.add(timeFormat.format(from.add(Duration(minutes: i * interval))));
  }
  return list;
}

String getDateTimeFormatted(DateTime date) {
  var formatter = DateFormat("EEE MMM dd, yyyy");
  return formatter.format(date);
}

Icon showCreditCardBrandLogo(String cardBrand) {
  switch (cardBrand) {
    case 'Visa':
      return Icon(LineIcons.cc_visa, color: Global.lightGreyColor, size: 45);
      break;
    case 'MasterCard':
      return Icon(LineIcons.cc_mastercard,
          color: Global.lightGreyColor, size: 45);
      break;
    case 'AmericanExpress':
      return Icon(LineIcons.cc_amex, color: Global.lightGreyColor, size: 45);
      break;
    case 'Discover':
      return Icon(LineIcons.cc_discover,
          color: Global.lightGreyColor, size: 45);
      break;
    case 'DinnersClub':
      return Icon(LineIcons.cc_diners_club,
          color: Global.lightGreyColor, size: 45);
      break;
    case 'JCB':
      return Icon(LineIcons.cc_jcb, color: Global.lightGreyColor, size: 45);
      break;
    case 'UnionPay':
      return Icon(LineIcons.credit_card,
          color: Global.lightGreyColor, size: 45);
      break;
    default:
      return Icon(LineIcons.credit_card,
          color: Global.lightGreyColor, size: 45);
      break;
  }
}

bool isOpenedNow(Profile profile) {
  bool bIsOpened = false;

  if (profile != null && profile.isBusinessClose == null) {
    if (profile != null && profile.businessHours.isNotEmpty) {
      DateFormat dateTimeFormat = DateFormat("EEEE");
      DateTime now = DateTime.now();
      String weekDay = dateTimeFormat.format(now);
      dateTimeFormat = DateFormat("yyyy-M-dd");
      String currentDate = dateTimeFormat.format(now);
      dateTimeFormat = DateFormat("yyyy-M-dd hh:mm a");
      for (int i = 0; i < profile.businessHours.length; i++) {
        Map<String, dynamic> item =
            Map<String, dynamic>.from(profile.businessHours[i]);
        List<String> businessDays = item['business_days'] != null
            ? List<String>.from(item['business_days'])
            : [];

        if (businessDays.contains(weekDay)) {
          DateTime fromHour, endHour;
          try {
            String time = item['fromHour'].toUpperCase();
            fromHour = dateTimeFormat.parse(currentDate + " " + time);
            time = item['endHour'].toUpperCase();
            endHour = dateTimeFormat.parse(currentDate + " " + time);

//            DateTime fourHoursAgo = now.subtract(Duration(hours: 4));
//            now = fourHoursAgo;

            if (now.isAfter(fromHour) && now.isBefore(endHour)) {
              bIsOpened = true;
              break;
            }
          } catch (e) {
            tlog.error("error: ", e);
          }
        }
      }
    }
  } else {
    if (profile != null && !profile.isBusinessClose) {
      if (profile != null && profile.businessHours.isNotEmpty) {
        DateFormat dateTimeFormat = DateFormat("EEEE");
        DateTime now = DateTime.now();
        String weekDay = dateTimeFormat.format(now);
        dateTimeFormat = DateFormat("yyyy-M-dd");
        String currentDate = dateTimeFormat.format(now);
        dateTimeFormat = DateFormat("yyyy-M-dd hh:mm a");
        for (int i = 0; i < profile.businessHours.length; i++) {
          Map<String, dynamic> item =
              Map<String, dynamic>.from(profile.businessHours[i]);
          List<String> businessDays = item['business_days'] != null
              ? List<String>.from(item['business_days'])
              : [];

          if (businessDays.contains(weekDay)) {
            DateTime fromHour, endHour;
            try {
              String time = item['fromHour'].toUpperCase();
              fromHour = dateTimeFormat.parse(currentDate + " " + time);
              time = item['endHour'].toUpperCase();
              endHour = dateTimeFormat.parse(currentDate + " " + time);

              if (now.isAfter(fromHour) && now.isBefore(endHour)) {
                bIsOpened = true;
                break;
              }
            } catch (e) {
              tlog.error("error: ", e);
            }
          }
        }
      }
    }
  }

  return bIsOpened;
}

bool isInBusinessHours(Profile chefDetail, DateTime date) {
  bool bIsInBusinessHours = false;
  if (chefDetail != null && chefDetail.businessHours.isNotEmpty) {
    DateFormat dateTimeFormat = new DateFormat("EEEE");
    String weekDay = dateTimeFormat.format(date);
    dateTimeFormat = new DateFormat("yyyy-M-dd");
    String currentDate = dateTimeFormat.format(date);
    dateTimeFormat = new DateFormat("yyyy-M-dd hh:mm a");
    for (int i = 0; i < chefDetail.businessHours.length; i++) {
      Map<String, dynamic> item =
          Map<String, dynamic>.from(chefDetail.businessHours[i]);
      List<String> businessDays = item['business_days'] != null
          ? List<String>.from(item['business_days'])
          : [];
      if (businessDays.contains(weekDay)) {
        DateTime fromHour, endHour;
        try {
          String time = item['fromHour'].toUpperCase();
          fromHour = dateTimeFormat.parse(currentDate + " " + time);
          time = item['endHour'].toUpperCase();
          endHour = dateTimeFormat.parse(currentDate + " " + time);
          if (date.isAfter(fromHour) && date.isBefore(endHour)) {
            bIsInBusinessHours = true;
            break;
          }
        } catch (e) {
          tlog.error("isInBusinessHours:", e);
        }
      }
    }
  }
  return bIsInBusinessHours;
}

void showSystemMessage(BuildContext context, String title, String body,
    Global.StateCallback callback,
    {bool dismiss = false, int duration = 5}) {
  Scaffold.of(context).showSnackBar(
    CustomSnackBar(
      backgroundColor: Global.lightBackgroundColor,
      content: RichText(
        textScaleFactor: 1.0,
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
                text: title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16)),
            TextSpan(
                text: "\n" + body,
                style: TextStyle(color: Colors.black, fontSize: 14)),
          ],
        ),
      ),
      duration: Duration(seconds: duration),
      action: dismiss
          ? SnackBarAction(
              label: "Ok",
              textColor: Colors.white,
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
                callback();
              },
            )
          : null,
    ),
  );
}

Future<Null> sendAnalytics(String name,
    [Map<String, dynamic> parameters]) async {
  TakeIn.analytics.aLogEvent(name: name, parameters: parameters);
}

bool isInternetConnectionAvailable(connectionStatus) {
  if (connectionStatus == ConnectivityStatus.wifi ||
      connectionStatus == ConnectivityStatus.mobile ||
      connectionStatus == null) {
    return true;
  } else {
    return false;
  }
}

Future<String> createShareUriDeepLinking(String type, String id) async {
  if (type == "producer" ||
      type == "chef" ||
      type == "handle" ||
      type == "tag") {
    return 'https://view.takein.${Global.domainEnv}/producer/$id';
  } else {
    return 'https://view.takein.${Global.domainEnv}/product/$id';
  }
}

void registerReservedDishToCart(BuildContext context) async {
  ProfileBloc _profileBloc = ProfileBloc();

  String dropoffName,
      dropoffPhoneNumber,
      dropoffAddress,
      dropoffAddress2,
      dropoffAddressInstruction;
  String pickupAddress = "",
      pickupAddress2 = "",
      pickupName = "",
      pickupPhoneNumber = "",
      pickupAddressInstruction = "";

  var response = await _profileBloc.myProfile(Global.loginUid);
  var profile = _profileBloc.docToProfile(response);
  if (profile != null) {
    dropoffName = profile.name != null ? profile.name : "";
    dropoffPhoneNumber = profile.phone != null ? profile.phone : "";
    if (profile.addresses != null && profile.addresses.isNotEmpty) {
      dropoffAddress = profile.addresses.first.formattedAddress != null
          ? profile.addresses.first.formattedAddress
          : "";
      dropoffAddress2 = profile.addresses.first.address2 != null
          ? profile.addresses.first.address2
          : "";
      dropoffAddressInstruction =
          profile.addresses.first.addressInstruction != null
              ? profile.addresses.first.addressInstruction
              : "";
    }
  } else {
    dropoffAddress = TakeInLocalizations.of(context).menuCurrentLocation;
    dropoffAddress2 = "";
    dropoffAddressInstruction = "";
    dropoffName = "";
    dropoffPhoneNumber = "";
  }

  Repository repository = Repository();
  Map result =
      await repository.getChefDetails(Global.reservedCartList.first.dish.uId);

  Map<String, dynamic> chefDetail = Map<String, dynamic>.from(result);

  if (chefDetail != null) {
    pickupPhoneNumber = chefDetail['businessPhone'] != null &&
            chefDetail['businessPhone'].toString().isNotEmpty
        ? chefDetail['businessPhone']
        : chefDetail['phone'] != null ? chefDetail['phone'] : "";

    if (chefDetail != null && chefDetail['addresses'] != null) {
      List<dynamic> addresses = List.from(chefDetail["addresses"]);
      if (addresses.length > 0) {
        Address address =
            Address.fromJson(Map<String, dynamic>.from(addresses[0]));
        pickupAddress = address.formattedAddress;
        pickupAddress2 = address.address2;
        pickupAddressInstruction = address.addressInstruction;
      }
    }

    if (chefDetail != null &&
        (chefDetail['name'] != null || chefDetail['businessName'] != null)) {
      pickupName = chefDetail['businessName'] != null &&
              chefDetail['businessName'].toString().isNotEmpty
          ? chefDetail['businessName']
          : chefDetail['name'] != null ? chefDetail['name'] : "";
    }
  }

  UserProfileBloc userProfileBloc =
      Provider.of<UserProfileBloc>(context, listen: false);
  Profile localUser = userProfileBloc.getUserFromLocalDb();

  var cartData = {
    'updatedTime': DateTime.now().millisecondsSinceEpoch,
    "cart": Global.reservedCartList.map((cartModel) {
      return cartModel.toJson();
    }).toList(),
    'checkout': {
      'delivery': {
        'dropoff_address': dropoffAddress,
        'dropoff_address2': dropoffAddress2,
        'dropoff_address_instruction': dropoffAddressInstruction,
        'dropoff_phone_number': dropoffPhoneNumber,
        'dropoff_name': dropoffName,
        'pickup_address': pickupAddress,
        'pickup_address2': pickupAddress2,
        'pickup_address_instruction': pickupAddressInstruction,
        'pickup_phone_number': pickupPhoneNumber,
        'pickup_name': pickupName,
      },
      'deliveryMethod': 'delivery',
      'payment': {
        'tip_amount': 10,
        'tip_type': "\%",
        'source': localUser.defaultPaymentMethod
      }
    }
  };

  userProfileBloc.addDataToCart(Global.loginUid, cartData).then((result) {
    Global.reservedCartList.clear();
    Navigator.of(context).pushReplacementNamed('/cart');
  }).catchError((e) {
    tlog.error("addDataToCart", e);
    Global.reservedCartList.clear();
    Navigator.of(context).pushReplacementNamed('/dashboard');
  });
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1), radix: 16) + 0xFF000000);
}

bool isImageUrl(String url) {
  if (url == null || url.isEmpty) {
    return true;
  }
  url = url.toLowerCase();
  if (url.endsWith("jpeg") ||
      url.endsWith("jpg") ||
      url.endsWith("png") ||
      url.endsWith("gif")) {
    return true;
  }

  return false;
}

bool validImage(String imageUrl) {
  return imageUrl != null &&
      imageUrl.isNotEmpty &&
      imageUrl != '' &&
      imageUrl != 'null';
}

bool hasPhoto(List<dynamic> photos) {
  return photos != null && photos.length > 0 && validImage(photos[0]);
}

bool hasValue(String value) {
  return value != null && value.isNotEmpty;
}

SvgPicture getProductSVG(String name, {color = Global.selectedRedColor}) {
  if (name == null || name == "") return getDefaultProductSvg(color: color);
  String label = name.toLowerCase();
  if (productSvgMap[label] != null) {
    // check cache
    if (productSvgCache[label] != null) {
      // return cache
      return productSvgCache[label];
    }
    SvgPicture svg = SvgPicture.asset(
      'assets/svg/${productSvgMap[label]}',
      color: color,
      width: 40,
    );
    productSvgCache[label] = svg;
    return svg;
  } else {
    return getDefaultProductSvg(color: color);
  }
}

SvgPicture getDefaultProductSvg({color = Global.selectedRedColor}) {
  if (productSvgCache["default"] != null) {
    return productSvgCache["default"];
  }
  SvgPicture svg = SvgPicture.asset(
    'assets/svg/${productSvgMap["default"]}',
    color: color,
    width: 35,
  );
  productSvgCache["default"] = svg;
  return svg;
}

Future<bool> isValidPhone(String phoneNumber) async {
  return await PhoneNumberUtil.isValidPhoneNumber(
      phoneNumber: phoneNumber, isoCode: 'US');
}

Future<String> normalizePhoneNumber(String phoneNumber) async {
  return await PhoneNumberUtil.normalizePhoneNumber(
      phoneNumber: phoneNumber, isoCode: 'US');
}
