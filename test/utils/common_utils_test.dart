import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'package:takein/utils/common_utils.dart';


void main() {
    WidgetsFlutterBinding.ensureInitialized();

  test('Parse DateTime', () {
    final mydate = parseDateTimeInIso('2019/06/19','11:00 PM');
    //print(mydate);
    expect(mydate, '2019-06-19T23:00:00-07:00');
  });
  test('Whole Day Series', (){
    List<String> list = generateTimeSeries(DateTime(0, 0, 0, 0, 0), DateTime(0, 0, 0, 24, 0), 15, true);
    expect(list[0], '12:00 AM');
  });

test('From 7am to 24pm', (){
    List<String> list = generateTimeSeries(DateTime(0, 0, 0, 7, 0), DateTime(0, 0, 0, 24, 0), 15, false);
    expect(list[0], '07:00 AM');
  });

test('Get pizza SVG', (){
  var productSVG = getProductSVG("pizza");  
  expect(productSVG, isNotNull);
  });

test('Get invalid SVG', (){
  var productSVG = getProductSVG("xinvalid");  
  expect(productSVG, isNull);
  });

test('Get Phone number', (){
  var result = isValidPhone("xinvalid");  
  expect(result, isFalse);
  });
test('Test Valid Phone', ()async {
  var result = await isValidPhone("9493121234");  
  print('---------- ${result}');
  expect(result, isTrue);
  });
  
}


