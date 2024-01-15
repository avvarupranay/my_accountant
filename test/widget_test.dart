// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_accountant/App%20Bloc/app_auth_bloc.dart';
import 'package:my_accountant/Data%20Layer/firebase_data_layer.dart';

import 'package:my_accountant/main.dart';

void main() {

  late MyAccountantRepository appRepository;
  late AppAuthState initialState;


  setUpAll(() {
    appRepository = MyAccountantRepository();
    initialState = appRepository.initialState;
  });


  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    final c = find.byKey(const Key("LoginEmailEntry"));
    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp(firebaseRepository: appRepository, initialAuthenticationState: initialState,));
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
