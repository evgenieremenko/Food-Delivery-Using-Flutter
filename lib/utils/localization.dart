import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

class TakeInLocalizations {
  static Future<TakeInLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return TakeInLocalizations();
    });
  }

  static TakeInLocalizations of(BuildContext context) {
    return Localizations.of<TakeInLocalizations>(context, TakeInLocalizations);
  }

  //for App title
  String get splashTitle {
    return Intl.message(
      'Fresh Local Food',
      name: 'splashTitle',
      desc: 'Title for the Demo application',
    );
  }

  //for Home Page
  String get menuHome {
    return Intl.message(
      'Home',
      name: 'menuHome',
    );
  }

  String get menuOffice {
    return Intl.message(
      'Office',
      name: 'menuOffice',
    );
  }

  String get menuCurrentLocation {
    return Intl.message(
      'Current Location',
      name: 'menuCurrentLocation',
    );
  }

  String get menuNew {
    return Intl.message(
      'New ...',
      name: 'menuNew',
    );
  }

  String get availableNow {
    return Intl.message(
      'AVAILABLE NOW',
      name: 'availableNow',
    );
  }

  String get popularDishes {
    return Intl.message(
      'POPULAR DISHES',
      name: 'popularDishes',
    );
  }

  String get newDishes {
    return Intl.message(
      'NEW DISHES',
      name: 'newDishes',
    );
  }

  //for search and location
  String get chefs {
    return Intl.message(
      'CHEFS',
      name: 'chefs',
    );
  }

  String get restaurants {
    return Intl.message(
      'RESTAURANTS',
      name: 'restaurants',
    );
  }

  String get dishes {
    return Intl.message(
      'DISHES',
      name: 'dishes',
    );
  }

  String get comingSoon {
    return Intl.message(
      'Coming Soon!',
      name: 'comingSoon',
    );
  }

  String get country {
    return Intl.message(
      'Country : ',
      name: 'country',
    );
  }

  String get local {
    return Intl.message(
      'Local : ',
      name: 'local',
    );
  }

  String get typeName {
    return Intl.message(
      'Type a name to search',
      name: 'typeName',
    );
  }

  //for component
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
    );
  }

  String get preOrder {
    return Intl.message(
      'Pre-Order',
      name: 'preOrder',
    );
  }

  String get available {
    return Intl.message(
      'Available',
      name: 'available',
    );
  }

  String get availablility {
    return Intl.message(
      'Availablility',
      name: 'availablility',
    );
  }

  String get follow {
    return Intl.message(
      'FOLLOW',
      name: 'follow',
    );
  }

  String get unFollow {
    return Intl.message(
      'UNFOLLOW',
      name: 'unFollow',
    );
  }

  String get portion {
    return Intl.message(
      'Portion',
      name: 'portion',
    );
  }

  String get pickupDate {
    return Intl.message(
      'Pickup Date',
      name: 'pickupDate',
    );
  }

  String get pickupTime {
    return Intl.message(
      'Pickup Time',
      name: 'pickupTime',
    );
  }

  String get left {
    return Intl.message(
      'left',
      name: 'left',
    );
  }

  String get recentlyOrdered {
    return Intl.message(
      'Recently Ordered',
      name: 'recentlyOrdered',
    );
  }

  String get mostPopular {
    return Intl.message(
      'Most Popular',
      name: 'mostPopular',
    );
  }

  //for chef details
  String get menu {
    return Intl.message(
      'MENU',
      name: 'menu',
    );
  }

  String get review {
    return Intl.message(
      'REVIEW',
      name: 'review',
    );
  }

  String get kitchenPhotos {
    return Intl.message(
      'KITCHEN PHOTOS',
      name: 'kitchenPhotos',
    );
  }

  String get photos {
    return Intl.message(
      'PHOTOS',
      name: 'photos',
    );
  }

  String get videos {
    return Intl.message(
      'VIDEOS',
      name: 'videos',
    );
  }

  String get dishPhotos {
    return Intl.message(
      'DISH PHOTOS',
      name: 'dishPhotos',
    );
  }

  //for cart cancel
  String get reasonToCancel {
    return Intl.message(
      'Reason to Cancel',
      name: 'reasonToCancel',
    );
  }

  String get reasonToCancelHint {
    return Intl.message(
      'Please let us know why you would like to cancel...',
      name: 'reasonToCancelHint',
    );
  }

  String get rescheduleAsk {
    return Intl.message(
      'Would you like to reschedule instead?',
      name: 'rescheduleAsk',
    );
  }

  String get pickup {
    return Intl.message(
      'Pickup',
      name: 'pickup',
    );
  }

  String get today {
    return Intl.message(
      'TODAY',
      name: 'today',
    );
  }

  String get later {
    return Intl.message(
      'Later',
      name: 'later',
    );
  }

  String get range {
    return Intl.message(
      'Range is ',
      name: 'range',
    );
  }

  String get time {
    return Intl.message(
      'Time',
      name: 'time',
    );
  }

  String get sendReschedule {
    return Intl.message(
      'SEND RESCHEDULE',
      name: 'sendReschedule',
    );
  }

  String get cancelOrder {
    return Intl.message(
      'CANCEL ORDER',
      name: 'cancelOrder',
    );
  }

  //for cart send
  String get gotOrder {
    return Intl.message(
      'WE GOT YOUR ORDER.',
      name: 'gotOrder',
    );
  }

  String get getReadyTo {
    return Intl.message(
      'Get ready to ',
      name: 'getReadyTo',
    );
  }

  String get take {
    return Intl.message(
      'take',
      name: 'take',
    );
  }

  String get takein {
    return Intl.message(
      'in',
      name: 'takein',
    );
  }

  String get location {
    return Intl.message(
      'LOCATION',
      name: 'location',
    );
  }

  String get type {
    return Intl.message(
      'Type ',
      name: 'type',
    );
  }

  String get message {
    return Intl.message(
      ' a message',
      name: 'message',
    );
  }

  String get send {
    return Intl.message(
      'SEND',
      name: 'send',
    );
  }

  String get addMore {
    return Intl.message(
      'Add More',
      name: 'addMore',
    );
  }

  String get cart {
    return Intl.message(
      'CART',
      name: 'cart',
    );
  }

  String get iamAt {
    return Intl.message(
      'I am at ',
      name: 'iamAt',
    );
  }

  String get house {
    return Intl.message(
      'house',
      name: 'house',
    );
  }

  //for cart
  String get cardEncoding1234 {
    return Intl.message(
      'Card Encoding 1234',
      name: 'cardEncoding1234',
    );
  }

  String get paypal {
    return Intl.message(
      'Paypal',
      name: 'paypal',
    );
  }

  String get payoneer {
    return Intl.message(
      'Payoneer',
      name: 'payoneer',
    );
  }

  String get order {
    return Intl.message(
      'ORDER',
      name: 'order',
    );
  }

  String get payment {
    return Intl.message(
      'PAYMENT',
      name: 'payment',
    );
  }

  String get addPromoCode {
    return Intl.message(
      'Add a promo code',
      name: 'addPromoCode',
    );
  }

  String get addNote {
    return Intl.message(
      'Add a note (for restaurant)',
      name: 'addNote',
    );
  }

  String get subTotal {
    return Intl.message(
      'Subtotal',
      name: 'subTotal',
    );
  }

  String get taxAndFees {
    return Intl.message(
      'Taxes and Fees',
      name: 'taxAndFees',
    );
  }

  String get deliveryFee {
    return Intl.message(
      'Delivery Fee',
      name: 'deliveryFee',
    );
  }

  String get total {
    return Intl.message(
      'Total',
      name: 'total',
    );
  }

  String get placeOrder {
    return Intl.message(
      'PLACE ORDER',
      name: 'placeOrder',
    );
  }

  String get taxAndFeesBreakDown {
    return Intl.message('Taxes and Fees Breakdown',
        name: 'taxAndFeesBreakDown');
  }

  String get tax {
    return Intl.message('Tax', name: 'tax');
  }

  String get serviceFee {
    return Intl.message('Service Fee', name: 'serviceFee');
  }

  String get authorization {
    return Intl.message('Authorization', name: 'authorization');
  }

  String get authDescription {
    return Intl.message(
        'Your card maybe temporarily authorized for more than your final order. This will be adjusted when your order is completed.',
        name: 'authDescription');
  }

  String get ok {
    return Intl.message('OK', name: 'ok');
  }

  //for chef_house
  String get welcome {
    return Intl.message('WELCOME!', name: 'welcome');
  }

  String get atTheDoor {
    return Intl.message('at the door', name: 'atTheDoor');
  }

  String get willBeMeetingYou {
    return Intl.message(' will be meeting you ', name: 'willBeMeetingYou');
  }

  String get call {
    return Intl.message('CALL ', name: 'call');
  }

  //for edit Profile
  String get changePassword {
    return Intl.message('CHANGE PASSWORD', name: 'changePassword');
  }

  String get fullName {
    return Intl.message('FULL NAME', name: 'fullName');
  }

  String get phoneNumber {
    return Intl.message('PHONE NUMBER ', name: 'phoneNumber');
  }

  String get optional {
    return Intl.message('(Optional)', name: 'optional');
  }

  String get yourPhoneNumber {
    return Intl.message('Your Phone Number', name: 'yourPhoneNumber');
  }

  String get address01 {
    return Intl.message('ADDRESS 01 *', name: 'address01');
  }

  String get yourAddress {
    return Intl.message('Your Address', name: 'yourAddress');
  }

  String get address02 {
    return Intl.message('ADDRESS 02 ', name: 'address02');
  }

  String get city {
    return Intl.message('CITY *', name: 'city');
  }

  String get hollywood {
    return Intl.message('Hollywood', name: 'hollywood');
  }

  String get state {
    return Intl.message('STATE *', name: 'state');
  }

  String get zipCode {
    return Intl.message('ZIPCODE *', name: 'zipCode');
  }

  String get creditCardNumber {
    return Intl.message('CREDIT CARD NUMBER', name: 'creditCardNumber');
  }

  String get edit {
    return Intl.message('EDIT', name: 'edit');
  }

  String get ending1234 {
    return Intl.message('Ending 1234', name: 'ending1234');
  }

  String get editProfile {
    return Intl.message('EDIT PROFILE', name: 'editProfile');
  }

  //for filter
  String get recommended {
    return Intl.message('Recommended', name: 'recommended');
  }

  String get all {
    return Intl.message('All', name: 'all');
  }

  String get authentic {
    return Intl.message('Authentic', name: 'authentic');
  }

  String get authenticEthnic {
    return Intl.message('Authentic\nEthnic', name: 'authenticEthnic');
  }

  String get family {
    return Intl.message('Family', name: 'family');
  }

  String get foodFilter {
    return Intl.message('FOOD FILTERS', name: 'foodFilter');
  }

  String get chefFilter {
    return Intl.message('CHEF FILTERS', name: 'chefFilter');
  }

  String get resetAll {
    return Intl.message('RESET ALL', name: 'resetAll');
  }

  String get sortby {
    return Intl.message('Sort by', name: 'sortby');
  }

  String get status {
    return Intl.message('STATUS', name: 'status');
  }

  String get online {
    return Intl.message('Online', name: 'online');
  }

  String get offline {
    return Intl.message('Offline', name: 'offline');
  }

  String get any {
    return Intl.message('Any', name: 'any');
  }

  String get price {
    return Intl.message('price', name: 'price');
  }

  String get rating {
    return Intl.message('rating', name: 'rating');
  }

  String get less {
    return Intl.message(' or less', name: 'less');
  }

  String get gender {
    return Intl.message('GENDER', name: 'gender');
  }

  String get female {
    return Intl.message('Female', name: 'female');
  }

  String get male {
    return Intl.message('Male', name: 'male');
  }

  String get age {
    return Intl.message('Age', name: 'age');
  }

  String get distance {
    return Intl.message('DISTANCE', name: 'distance');
  }

  String get deliveryOption {
    return Intl.message('DELIVERY OPTION', name: 'deliveryOption');
  }

  String get delivery {
    return Intl.message('Delivery', name: 'delivery');
  }

  String get cuisine {
    return Intl.message('CUISINE', name: 'cuisine');
  }

  String get familyMeal {
    return Intl.message('Family\nMeal', name: 'familyMeal');
  }

  String get privateEvent {
    return Intl.message('Private\nEvent', name: 'privateEvent');
  }

  String get roadTrip {
    return Intl.message('Road\nTrip', name: 'roadTrip');
  }

  String get dietaryControl {
    return Intl.message('DIETARY CONTROL', name: 'dietaryControl');
  }

  String get lactoseIntolerance {
    return Intl.message('Lactose intolerance', name: 'lactoseIntolerance');
  }

  String get keto {
    return Intl.message('Keto', name: 'keto');
  }

  String get vegetarian {
    return Intl.message('Vegetarian', name: 'vegetarian');
  }

  String get glutenFree {
    return Intl.message('Gluten Free', name: 'glutenFree');
  }

  String get medit {
    return Intl.message('Medite', name: 'medit');
  }

  String get vegan {
    return Intl.message('Vegan', name: 'vegan');
  }

  String get paleo {
    return Intl.message('Paleo', name: 'paleo');
  }

  String get kosher {
    return Intl.message('Kosher', name: 'kosher');
  }

  String get halal {
    return Intl.message('Halal', name: 'halal');
  }

  String get peanutAllergies {
    return Intl.message('Peanut Allergies', name: 'peanutAllergies');
  }

  String get raw {
    return Intl.message('Raw', name: 'raw');
  }

  String get numberOfPortions {
    return Intl.message('NUMBER OF PORTIONS', name: 'numberOfPortions');
  }

  String get apply {
    return Intl.message('APPLY', name: 'apply');
  }

  //for food details
  String get description {
    return Intl.message('description', name: 'description');
  }

  String get ingredient {
    return Intl.message('INGREDIENT', name: 'ingredient');
  }

  String get caution {
    return Intl.message('Caution', name: 'caution');
  }

  String get portionDetails {
    return Intl.message('Portion details', name: 'portionDetails');
  }

  String get fettucine {
    return Intl.message('Contains 1 lb fettucine', name: 'fettucine');
  }

  String get feedPerson {
    return Intl.message('Feeds 1 person', name: 'feedPerson');
  }

  String get chef {
    return Intl.message(
      'CHEF',
      name: 'chef',
    );
  }

  String get startNewCart {
    return Intl.message(
      'Start a New Cart?',
      name: 'startNewCart',
    );
  }

  String get alreadyHaveCart {
    return Intl.message(
      "Your cart already contain an item from %s",
      name: 'alreadyHaveCart',
    );
  }

  String get proceedCart {
    return Intl.message(
      'Add the cart items from %s',
      name: 'proceedCart',
    );
  }

  String get replaceCart {
    return Intl.message(
      'Clear the cart items from %s and add item from Chef %s',
      name: 'replaceCart',
    );
  }

  String get cancelCart {
    return Intl.message(
      'Cancel from chef %s',
      name: 'cancelCart',
    );
  }

  //for menu
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
    );
  }

  String get needHelp {
    return Intl.message(
      'Need Help?',
      name: 'needHelp',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
    );
  }

  String get myoders {
    return Intl.message(
      'My Orders',
      name: 'myoders',
    );
  }

  String get followings {
    return Intl.message(
      'Followings',
      name: 'followings',
    );
  }

  String get favoritePlaces {
    return Intl.message(
      'Favorite Places',
      name: 'favoritePlaces',
    );
  }

  String get favoriteDishes {
    return Intl.message(
      'Favorite Dishes',
      name: 'favoriteDishes',
    );
  }

  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
    );
  }

  //for order page
  String get currentOrders {
    return Intl.message(
      'Current Orders',
      name: 'currentOrders',
    );
  }

  String get pastOrders {
    return Intl.message(
      'Past Orders',
      name: 'pastOrders',
    );
  }

  //for current order page
  String get currentOrderCardEnding {
    return Intl.message(
      'Card Ending',
      name: 'currentOrderCardEnding',
    );
  }

  String get promoCode {
    return Intl.message(
      'Promo Code',
      name: 'promoCode',
    );
  }

  String get orderAgain {
    return Intl.message(
      'ORDER AGAIN',
      name: 'orderAgain',
    );
  }

  //for order
  String get thirdPartyPickup {
    return Intl.message(
      '3rd Party Pickup',
      name: 'thirdPartyPickup',
    );
  }

  String get pickedup {
    return Intl.message(
      'Picked up',
      name: 'pickedup',
    );
  }

  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
    );
  }

  String get orderingFrom {
    return Intl.message(
      'ORDERING FROM:',
      name: 'orderingFrom',
    );
  }

  String get addToCart {
    return Intl.message(
      'ADD TO CART',
      name: 'addToCart',
    );
  }

  String get editCart {
    return Intl.message('Edit Cart', name: 'editCart');
  }

  String get enterNewAddress {
    return Intl.message(
      'Enter New Address',
      name: 'enterNewAddress',
    );
  }

  String get typeAddress {
    return Intl.message(
      '',
      name: 'typeAddress',
    );
  }

  String get change {
    return Intl.message(
      'Change',
      name: 'change',
    );
  }

  String get addressError {
    return Intl.message(
      'There is no such address. Try again',
      name: 'addressError',
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
    );
  }

  //for profile_view
  String get previousOrders {
    return Intl.message(
      'Previous Orders',
      name: 'previousOrders',
    );
  }

  String get breakfastItems {
    return Intl.message(
      'BREAKFAST ITEMS',
      name: 'breakfastItems',
    );
  }

  String get appitizers {
    return Intl.message(
      'APPITIZERS',
      name: 'appitizers',
    );
  }

  String get entrees {
    return Intl.message(
      'ENTREES',
      name: 'entrees',
    );
  }

  String get viewProfile {
    return Intl.message(
      'VIEW PROFILE',
      name: 'viewProfile',
    );
  }

  String get checkOut {
    return Intl.message(
      'CHECK OUT',
      name: 'checkOut',
    );
  }

  // for add address page
  String get useCurrentLocation {
    return Intl.message(
      'Use Current Location',
      name: 'useCurrentLocation',
    );
  }

  // for setup address page

  String get save {
    return Intl.message(
      'SAVE',
      name: 'save',
    );
  }

  String get deliverToDoor {
    return Intl.message(
      'Deliver to door',
      name: 'deliverToDoor',
    );
  }

  String get pickupOutside {
    return Intl.message(
      'Pick up outside',
      name: 'pickupOutside',
    );
  }

  String get addressName {
    return Intl.message(
      'Address Name',
      name: 'addressName',
    );
  }

  String get exAddresses {
    return Intl.message(
      '(EX: Home, Office, Mom\'s House...)',
      name: 'exAddresses',
    );
  }

  String get aptSuiteFloor {
    return Intl.message(
      'Apt/Suite/Floor',
      name: 'aptSuiteFloor',
    );
  }

  String get exAptSuiteFloor {
    return Intl.message(
      '(EX: Unit 1, Floor 2, Suite A...)',
      name: 'exAptSuiteFloor',
    );
  }

  String get deliveryNote {
    return Intl.message(
      'Delivery Note',
      name: 'deliveryNote',
    );
  }

  String get exDeliveryNote {
    return Intl.message(
      'Please type',
      name: 'exDeliveryNote',
    );
  }

  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
    );
  }

  String get cardExample {
    return Intl.message(
      '(XXXX-XXXX-XXXX-XXXX)',
      name: 'cardExample',
    );
  }

  String get cvvCode {
    return Intl.message(
      'CVV',
      name: 'cvvCode',
    );
  }

  String get cvvExample {
    return Intl.message(
      '123',
      name: 'cvvExample',
    );
  }

  String get expirationDate {
    return Intl.message(
      'Expiration Date',
      name: 'expirationDate',
    );
  }

  String get expirationDateExample {
    return Intl.message(
      'MM/YY',
      name: 'expirationDateExample',
    );
  }

  //for rate_chef
  String get enjoy {
    return Intl.message(
      'ENJOY!',
      name: 'enjoy',
    );
  }

  String get pleaseRate {
    return Intl.message(
      'Please rate ',
      name: 'pleaseRate',
    );
  }

  String get sayThankYou {
    return Intl.message(
      'SAY THANK YOU...',
      name: 'sayThankYou',
    );
  }

  String get rate {
    return Intl.message(
      'rate',
      name: 'rate',
    );
  }

  String get submit {
    return Intl.message(
      'submit',
      name: 'submit',
    );
  }

  //for sign
  String get foodApp {
    return Intl.message(
      'Food App',
      name: 'foodApp',
    );
  }

  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
    );
  }

  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
    );
  }

  String get email {
    return Intl.message(
      'EMAIL',
      name: 'email',
    );
  }

  String get password {
    return Intl.message(
      'PASSWORD',
      name: 'password',
    );
  }

  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
    );
  }

  String get orConnectWith {
    return Intl.message(
      'OR CONNECT WITH',
      name: 'orConnectWith',
    );
  }

  String get validFullName {
    return Intl.message(
      'Full name shouldn\'t empty string',
      name: 'validFullName',
    );
  }

  String get validPhoneNumber {
    return Intl.message(
      'Phone Number is not valid',
      name: 'validPhoneNumber',
    );
  }

  String get validEmail {
    return Intl.message(
      'Enter Valid Email',
      name: 'validEmail',
    );
  }

  String get validPassword {
    return Intl.message(
      'Password must be greater than 5 characters.',
      name: 'validPassword',
    );
  }

  String get validHandle {
    return Intl.message(
      'Handle must be greater than 5 characters.',
      name: 'validHandle',
    );
  }

  String get existHandle {
    return Intl.message(
      'This handle is not available or has been used by others.',
      name: 'existHandle',
    );
  }

  String get confirmPassword {
    return Intl.message(
      'CONFIRM PASSWORD',
      name: 'confirmPassword',
    );
  }

  String get validConfirmPassword {
    return Intl.message(
      'Please confirm password again.',
      name: 'validConfirmPassword',
    );
  }

  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
    );
  }

  String get emailNotVerified {
    return Intl.message(
      'Sorry, your email(%s) is not verified.',
      name: 'emailNotVerified',
    );
  }

  String get sendVerificationEmail {
    return Intl.message(
      'SEND VERIFICATION EMAIL',
      name: 'sendVerificationEmail',
    );
  }

  String get unknownError {
    return Intl.message(
      'Unknown error!',
      name: 'unknownError',
    );
  }

  String get verifyEmail {
    return Intl.message(
      'Please confirm and verify your email.',
      name: 'verifyEmail',
    );
  }

  String get addresses {
    return Intl.message(
      'Addresses',
      name: 'addresses',
    );
  }

  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
    );
  }

  String get addNew {
    return Intl.message(
      'ADD NEW',
      name: 'addNew',
    );
  }

  String get addCreditCard {
    return Intl.message(
      'ADD CREDIT CARD',
      name: 'addCreditCard',
    );
  }

  String get servedBy {
    return Intl.message(
      'Served by',
      name: 'servedBy',
    );
  }

  String get places {
    return Intl.message(
      'Places',
      name: 'places',
    );
  }

  String get specialInstruction {
    return Intl.message(
      'Special Instruction',
      name: 'specialInstruction',
    );
  }

  String get addSpecialInstruction {
    return Intl.message(
      'Add Special Instruction...',
      name: 'addSpecialInstruction',
    );
  }

  String get aboutTakeIn {
    return Intl.message(
      'About TakeIn',
      name: 'aboutTakeIn',
    );
  }

  String get takeInCom {
    return Intl.message(
      'TakeIn.com',
      name: 'takeInCom',
    );
  }

  String get deliverySettings {
    return Intl.message(
      'Order options',
      name: 'deliverySettings',
    );
  }

  String get mealPreferences {
    return Intl.message(
      'Meal Preferences',
      name: 'mealPreferences',
    );
  }

  String get allowContactLess {
    return Intl.message(
      'Contactless delivery',
      name: 'allowContactLess',
    );
  }

  String get needNapkin {
    return Intl.message(
      'Need Napkin',
      name: 'needNapkin',
    );
  }

  String get needUtensil {
    return Intl.message(
      'Need Utensil',
      name: 'needUtensil',
    );
  }

  String get contactlessHelperText {
    return Intl.message(
      '* Driver will notify you once the food has been dropped off.',
      name: 'contactlessHelperText',
    );
  }

  String get allowPhoneCalls {
    return Intl.message(
      'Allow phone calls',
      name: 'allowPhoneCalls',
    );
  }

  String get allowSMSMessages {
    return Intl.message(
      'Allow SMS messages',
      name: 'allowSMSMessages',
    );
  }

  String get deliveryDriverNote {
    return Intl.message(
      'Driver notes',
      name: 'deliveryDriverNote',
    );
  }

  String get foodsThatILike {
    return Intl.message(
      'Foods that I like',
      name: 'foodsThatILike',
    );
  }

  String get foodsThatIDontLike {
    return Intl.message(
      'Foods that I don\'t like much',
      name: 'foodsThatIDontLike',
    );
  }

  String get dietsFoodRestriction {
    return Intl.message(
      'Diets / Food Restriction',
      name: 'dietsFoodRestriction',
    );
  }

  String get cuisines {
    return Intl.message(
      'Cuisine',
      name: 'cuisine',
    );
  }

  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
    );
  }

  String get pleaseSelect {
    return Intl.message(
      'Please select one or more option(s)',
      name: 'pleaseSelect',
    );
  }
}

class TakeInLocalizationsDelegate
    extends LocalizationsDelegate<TakeInLocalizations> {
  const TakeInLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<TakeInLocalizations> load(Locale locale) =>
      TakeInLocalizations.load(locale);

  @override
  bool shouldReload(TakeInLocalizationsDelegate old) => false;
}
