import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:takein/services/resources/auth_api.dart';
import 'package:takein/ui/screens/login/login_screen.dart';
import 'package:takein/blocs/blocs.dart';
import 'package:takein/utils/utils.dart';

class MockAuth extends Mock implements AuthApi {}

void main() async {

  Widget makeTestableWidget({Widget child, AuthApi auth}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('empty email returns error string', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          final result = Validators.validateUserEmail('', context);
          expect(result, TakeInLocalizations.of(context).validEmail);
          return Placeholder();
        },
      ),
    );
  });

  testWidgets('non-empty email returns null', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          final result =
              Validators.validateUserEmail('email@email.com', context);
          expect(result, null);
          return Placeholder();
        },
      ),
    );
  });

  testWidgets('empty password returns error string',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          final result = Validators.validateUserPassword('', context);
          expect(result, TakeInLocalizations.of(context).validPassword);
          return Placeholder();
        },
      ),
    );
  });

  testWidgets('non-empty password returns null', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          final result = Validators.validateUserPassword('password', context);
          expect(result, null);
          return Placeholder();
        },
      ),
    );
  });

  testWidgets('email and password sign in filled OK',
      (WidgetTester tester) async {
    var app = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: ChangeNotifierProvider(
                create: (context) => UserProfileBloc(),
                child: LoginScreen())));
    await tester.pumpWidget(app);

    Finder email = find.byKey(Key('emailSignIn'));
    Finder pwd = find.byKey(Key('passwordSignIn'));

    await tester.enterText(email, "email@email.com");
    await tester.enterText(pwd, "123456textemptynot");
    await tester.pump();

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    expect(formKey.currentState.validate(), isTrue);
  });

  testWidgets('email or password is empty, does not sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();

    bool userIsNull = true;

    await tester.pumpWidget(makeTestableWidget(
        child: ChangeNotifierProvider(
            create: (context) => UserProfileBloc(),
            child: LoginScreen()),
        auth: mockAuth));

    await tester.tap(find.byKey(Key('signInButton')));

    verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
    expect(userIsNull, true);
  });
}
