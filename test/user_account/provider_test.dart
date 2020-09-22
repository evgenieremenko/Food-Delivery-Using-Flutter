import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// Run this test: flutter test test/user_account/provider_test.dart

void main() async {

  Location _locationModel;

  StreamController<Location> _controller;

  setUp(() {
    _controller = StreamController<Location>();
    _locationModel = Location(city: 'San Diego');
  });

  group('[Location Model]', () {

    test('[Model] Check individual values', () async {

      _locationModel = Location(
        city: 'San Diego',
        countryName: 'United States',
        country: 'United States',
        currency: '\$',
        ip: '',
        inEu: true,
        languages: 'EN',
      );

      // BEGIN TESTS....
      expect(_locationModel.city, 'San Diego');

      expect(_locationModel.countryName.runtimeType, equals(String));

      expect(_locationModel.country, isNotNull);

      expect(_locationModel.ip, isEmpty);

      expect(_locationModel.inEu, isTrue);

      expect(_locationModel.languages, contains('EN'));

      expect(_locationModel.currency, startsWith('\$'));

      expect(_locationModel.country, matches('United States'));
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
      expect(Provider.of<Location>(_childKey.currentContext), null);

      _controller.add(Location(city: 'San Diego'));

      // Delay the pump...
      await Future.microtask(tester.pump);

      // Check if the model passed (with some value) is the same as received...
      expect(
        Provider.of<Location>(_childKey.currentContext).toJson(),
        _locationModel.toJson(),
      );

      await _controller.close();
    });
  });
}


class Location {

  Location({
    this.city,
    this.country,
    this.countryName,
    this.currency,
    this.inEu,
    this.ip,
    this.languages,
  });

  String city;

  String country;

  String countryName;

  String currency;

  bool inEu;

  String ip;

  String languages;

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(
        city: json['city'],
        country: json['country'],
        countryName: json['countryName'],
        currency: json['currency'],
        inEu: json['inEu'],
        ip: json['ip'],
        languages: json['languages'],
      );

  Map<String, dynamic> toJson() => { 'city': city, 'country': country,
    'countryName': countryName, 'currency': currency, 'inEu': inEu, 'ip': ip,
    'languages': languages};
}
