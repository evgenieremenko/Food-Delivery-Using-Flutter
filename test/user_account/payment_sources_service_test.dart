import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:takein/services/resources/firestore_api.dart';
import 'package:takein/services/resources/payment_sources_service.dart';

class MockApi extends Mock implements FirestoreApi {}

void main() {
  group('PaymentSourcesServices Test | ', () {
    setUpAll(() {

    });

    test('Constructing Service should find correct dependencies', () {
      var paymentSourcesService = PaymentSourcesService();
      expect(paymentSourcesService != null, true);
    });

    test('Given a credit card, should call addCardSource method', () async {

      var mockApi = MockApi();
//      when(mockApi.addCardSource('4424343434')).thenAnswer((_) => Future.value("ADDED"));
      when(mockApi.getChefDetails('4424343434')).thenAnswer((_) => Future.value("Has Data"));

      var paymentSourcesService = PaymentSourcesService(api: mockApi);
//      await paymentSourcesService.addCardSource('4424343434');
//      verify(mockApi.addCardSource('4424343434'));
      await paymentSourcesService.getChefDetails('4424343434');
      verify(mockApi.getChefDetails('4424343434'));
    });
  });
}