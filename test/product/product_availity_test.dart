import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:takein/models/availability.dart';
import 'package:takein/models/menu_model.dart';
import 'package:takein/models/profile.dart';
import 'package:takein/services/resources/firestore_api_provider.dart';
import 'package:takein/services/resources/repository.dart';
import 'package:test/test.dart';

import 'package:takein/blocs/global/global_bloc.dart';



class FirestoreApiProviderMock extends Mock implements FirestoreApiProvider {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalBloc globalBloc;
  Repository repository;

  setUp(() async {
   FirestoreApiProviderMock firestoreApiProvider = FirestoreApiProviderMock();
    repository = Repository(        
        firestoreApiProvider: firestoreApiProvider);
    
    Hive.init('./hive/test');

    await Hive.openBox('chefs');
    await Hive.openBox('dishes');
    await Hive.openBox('menus');
    await Hive.openBox('restaurants');
    await Hive.openBox('lastCalls');
    await Hive.openBox('promotions');
    final chefsBox = Hive.box('chefs');
    final menuBox = Hive.box('menus');
    chefsBox.clear();
    menuBox.clear();

    Profile chef1 = Profile(handle: 'chef', uid: '100', savedTime:DateTime.now() );
    chef1.businessHours = List();
    var bizHours =   <dynamic, dynamic>{'endHour': '11:30 pm', 'fromHour': '07:00 am', 'business_days':['Monday','Tuesday','Wednesday','Friday','Thursday', 'Saturday','Sunday']}; 
    chef1.businessHours.add(bizHours);
    
     chefsBox.add(chef1).catchError((error) {
        print("chefsBox error: "+ error);
      });
      
      MenuModel menu1 = MenuModel(useBusinessHours: true, id: '10',  uid: '100', items: ['10'], savedTime:DateTime.now());
      MenuModel menu2 = MenuModel(useBusinessHours: false, id: '11',  uid: '100', items: ['11'], weekday:['NO'] , savedTime:DateTime.now());
      
      menuBox.add(menu1);
      menuBox.add(menu2);

    globalBloc = GlobalBloc(repository: repository);
  });

  tearDown(() {});

  group('ProductAvailable', () {
    test("Check Product is available", ()  async{
      Availability availability = await globalBloc.isAvailableNowCheck('10', '100');
      expect(availability.isAvailableNow, true);
    }); 
    test("Check Product is NOT available", ()  async{
      Availability availability = await globalBloc.isAvailableNowCheck('11', '100');
      expect(availability.isAvailableNow, false);
    });
  });
}
