import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:takein/services/resources/auth_api_provider.dart';
import 'package:takein/services/resources/firestore_api_provider.dart';
import 'package:takein/services/resources/repository.dart';
import 'package:test/test.dart';
import 'package:takein/blocs/global/global_bloc.dart';

import '../FirebaseMock.dart';

class FireStoreMock extends Mock implements Firestore {}
class FirebaseAuthMock extends Mock implements FirebaseAuth {}
//final Trace myTrace = FirebasePerformance.instance.newTrace("firestore_api");

void main() {
  //TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  GlobalBloc globalBloc;
  Repository repository;

  setUp(() async {
    FireStoreMock fireStore = FireStoreMock();
    FirebaseAuthMock firebaseAuth = FirebaseAuthMock();
    AuthApiProvider authenticationProvider =
        AuthApiProvider(firebaseAuth: firebaseAuth);
    CollectionReferenceMock collectionReference = CollectionReferenceMock();
    DocumentSnapshotMock documentSnapshot = DocumentSnapshotMock();

    DocumentReferenceMock documentReference = DocumentReferenceMock();
      documentReference =
          DocumentReferenceMock(documentSnapshotMock: documentSnapshot);

    when(fireStore.collection(any)).thenReturn(collectionReference);
    when(collectionReference.document(any)).thenReturn(documentReference);

    FirestoreApiProvider firestoreApiProvider =
        FirestoreApiProvider();
    repository = Repository(
        authApiProvider: authenticationProvider,
        firestoreApiProvider: firestoreApiProvider);
    Hive.init('./hive/test');

    await Hive.openBox('chefs');
    await Hive.openBox('dishes');
    await Hive.openBox('menus');
    await Hive.openBox('restaurants');
    await Hive.openBox('popularDishes');
    await Hive.openBox('lastCalls');
    await Hive.openBox('promotions');

    globalBloc = GlobalBloc(repository: repository);
  });

  tearDown(() {});

  group('ProductAvailable', () {
    test("Check Product is available", () {
      globalBloc.isAvailableNowCheck('1', '3');
    });
  });
}
